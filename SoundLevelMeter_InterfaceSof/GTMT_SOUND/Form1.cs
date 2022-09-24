using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
// Thư viện để sài SerialPort
using System.IO;
using System.IO.Ports;
using System.Xml;
//Dùng Excel
using Excel = Microsoft.Office.Interop.Excel;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

using System.Diagnostics;
// chú ý : Khai báo thư viện này
using ZedGraph;

// Bắt đầu code chính
namespace GTMT_SOUND
{
    public partial class Form1 : Form
    {
        //Khai bao bien toan cuc
        SerialPort P = new SerialPort(); // Khai báo 1 Object SerialPort mới.
        string InputData = String.Empty; // Khai báo string buff dùng cho hiển thị dữ liệu sau này.
        delegate void SetTextCallback(string text); // Khai bao delegate SetTextCallBack voi tham so string
        static int counter = 0, sosanh_dem = 10000;
        static DataTable dt = new DataTable();
        SetTextCallback d;
        //static string strArray;
        static string thoigian, file_thoigian;
        static int hang, cot;
        static bool ketnoi = false, bien_pause = true, pause_time = true;
        int tickStart = 0, i;
        string luudb;
        double time = 0;
        double delay = 0.5;
        double[] GiaTriDeLay = new double[4] { 0.5, 1, 2, 0.2 };
        //Khia báo biến ch đồ thị
        GraphPane myPane;
        RollingPointPairList list;
        LineItem curve;
        LineItem curve1;

        IPointListEdit list1;
        Scale xScale;
        double luugiatri;
        bool convert;

        public Form1()
        {
            InitializeComponent();
            // Cài đặt các thông số cho COM
            // Mảng string port để chứ tất cả các cổng COM đang có trên máy tính
            string[] ports = SerialPort.GetPortNames();

            // Thêm toàn bộ các COM đã tìm được vào combox cbCom
            cbCom.Items.AddRange(ports); // Sử dụng AddRange thay vì dùng foreach
            P.ReadTimeout = 1000;
            // Khai báo hàm delegate bằng phương thức DataReceived của Object SerialPort;
            // Cái này khi có sự kiện nhận dữ liệu sẽ nhảy đến phương thức DataReceive
            P.DataReceived += new SerialDataReceivedEventHandler(DataReceive);

            // Cài đặt cho BaudRate
            //string[] BaudRate = { "76800", "57600", "14400" };
            string[] BaudRate = { "57600" };
            cbRate.Items.AddRange(BaudRate);

            string[] Bien_Delay = { "0.5 s", "1 s", "2 s", "Free" };
            cbDelay.Items.AddRange(Bien_Delay);
        }
        //=============================================================
        //Sự kiện gán PortName cho COM
        private void cbCom_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (P.IsOpen)
            {
                P.Close(); // Nếu đang mở Port thì phải đóng lại
            }
            P.PortName = cbCom.SelectedItem.ToString(); // Gán PortName bằng COM đã chọn 
        }
        //=============================================================
        //Sự kiện gán Tốc độ Baud cho BaudRate
        private void cbRate_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (P.IsOpen)
            {
                P.Close();
            }
            P.BaudRate = Convert.ToInt32(cbRate.Text);
        }
        //==============================
        //Sự kiện gán Delay cho cbDelay
        private void cbDelay_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (P.IsOpen)
            {
                P.Write((cbDelay.SelectedIndex).ToString());
            }
            delay = GiaTriDeLay[cbDelay.SelectedIndex];
            if (ketnoi == true)
                time = time - delay;
            else
                time = -delay;
        }
        //=============================================================
        // Hàm này được sự kiện nhận dữ liệu gọi đến. Mục đích để hiển thị
        private void DataReceive(object obj, SerialDataReceivedEventArgs e)
        {
            InputData = P.ReadExisting();
            if (InputData != String.Empty) // Neus InputData khac ky tu trang, Empty: troongs
            {
                if (ketnoi == true && bien_pause == true)
                {
                    //txtIn.Text = InputData; // Ko dùng đc như thế này vì khác threads .
                    SetText(InputData); // Chính vì vậy phải sử dụng ủy quyền tại đây. Gọi delegate đã khai báo trước đó.
                }
            }
        }
        //=============================================================
        // Hàm DataReceive: Nhận dữ liệu
        private void SetText(string text)
        {

            if (this.txtadc.InvokeRequired) //InvokeRequired: goij yeeu caauf
            {
                try
                {
                    d = new SetTextCallback(SetText); // khởi tạo 1 delegate mới gọi đến SetText
                    this.Invoke(d, new object[] { text });
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi Hệ Thống, Vui Lòng Thử Kết Nối Lại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                if (text == "\n")
                {
                    this.txtadc.Text = "";
                    counter++;
                    if ((counter <= sosanh_dem))
                    {
                        // Add thêm hàng cho dataGridView1
                        dataGridView1.Rows.Add();
                    }
                    //DrawChart(20, 0);
                }
                else if (text == "\t")
                {
                    DrawChart(20, 0);
                }
                else
                {
                    //kiểm tra và nhận giá trị Delay từ phần cứng gửi đến
                    if (text == "@")
                        cbDelay.SelectedIndex = 0;
                    else if (text == "A")
                        cbDelay.SelectedIndex = 1;
                    else if (text == "B")
                        cbDelay.SelectedIndex = 2;
                    else if (text == "C")
                        cbDelay.SelectedIndex = 3;
                    ///////////
                    else
                        this.txtadc.Text += text;
                }

                //Đưa dữ liệu lưu vào dataGridView1
                if (counter > sosanh_dem)
                {
                    counter = sosanh_dem;
                    for (int i = 0; i < sosanh_dem - 1; i++)
                    {
                        //for (int j = 1; j < dataGridView1.Columns.Count; j++) //dùng khi có nhiều cột
                        dataGridView1.Rows[i].Cells[1].Value = dataGridView1.Rows[i + 1].Cells[1].Value;
                        dataGridView1.Rows[i].Cells[2].Value = dataGridView1.Rows[i + 1].Cells[2].Value;
                    }
                    //dataGridView1.Rows[sosanh_dem - 1].Cells[0].Value = counter;
                    dataGridView1.Rows[sosanh_dem - 1].Cells[1].Value = thoigian;
                    dataGridView1.Rows[sosanh_dem - 1].Cells[2].Value = txtadc.Text;

                    //int scrollLines = SystemInformation.VerticalScrollBarThumbHeight;
                    //this.dataGridView1.FirstDisplayedScrollingRowIndex = scrollLines;
                }
                else if (counter <= sosanh_dem + 2)
                {
                    dataGridView1.Rows[counter - 1].Cells[0].Value = counter;
                    dataGridView1.Rows[counter - 1].Cells[1].Value = thoigian;
                    dataGridView1.Rows[counter - 1].Cells[2].Value = txtadc.Text;
                    this.dataGridView1.FirstDisplayedScrollingRowIndex = dataGridView1.Rows.Count - 1;
                }
            }

            txtCounter.Text = counter.ToString();
            try
            {
                luudb = dataGridView1.Rows[counter - 1].Cells[2].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi Hệ Thống, Vui Lòng Thử Kết Nối Lại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        //==========================
        //============================================================= 
        //Khởi tạo khi Load Form
        private void Form1_Load(object sender, EventArgs e) // sẽ được gọi khi mở chương trình.
        {
            cbCom.SelectedIndex = 0;
            cbRate.SelectedIndex = 0;
            cbDelay.SelectedIndex = 3;

            // Hiện thị Status cho Pro tís
            status.ForeColor = Color.Red;
            status.Text = "Hãy chọn 1 cổng COM để kết nối.";
            btNgat.Enabled = false;
            btDeleteGraph.Enabled = false;
            btExportGraph.Enabled = false;
            //btXoa.Enabled = false;
            checkPause.Enabled = false;
            dataGridView1.RowHeadersVisible = true;
            dataGridView1.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            txtSampling.Text = sosanh_dem.ToString();
            progressBar1.Minimum = 0;
            txtCounter.Text = counter.ToString();
            aboutToolStripMenuItem.Visible = false;
            timer1.Enabled = true;

            KhoiTaoZedGraph();
        }
        //==================
        private void KhoiTaoZedGraph()
        {
            // khi khởi động sẽ được chạy biểu đồ
            myPane = zedGraphControl1.GraphPane; // Khai báo sửa dụng Graph loại GraphPane;
            // Các thông tin cho đồ thị của mình
            myPane.Title.Text = "Đồ Thị Độ Ồn Đo Được";
            myPane.XAxis.Title.Text = "Thời Gian (s)";
            myPane.YAxis.Title.Text = "SPL (dB)";

            //Màu nền cho biểu đồ
            //zedGraphControl1.GraphPane.Chart.Fill.Color = System.Drawing.Color.Black;
            //zedGraphControl1.GraphPane.Chart.Fill.Color = Color.Blue; //màu đậm dần
            zedGraphControl1.GraphPane.Chart.Fill = new Fill(Color.DarkSlateBlue, Color.DarkBlue, 90.0f); //màu nền như nhau cho tát cả

            // Định nghĩa list để vẽ đồ thị. Để các bạn hiểu rõ cơ chế làm việc ở đây khai báo 2 list điểm <=> 2 đường đồ thị
            list = new RollingPointPairList(1000000);
            // Ở đây sử dụng list với 1200 điểm (có thể thêm nhiều liệu tại đây)
            //RollingPointPairList list2 = new RollingPointPairList(1200);
            // dòng dưới là định nghĩa curve để vẽ.
            curve = myPane.AddCurve("Dạng Sóng", list, Color.Yellow, SymbolType.None); // Color màu đỏ, đặc trưng cho đường 1
            // SymbolType là kiểu biểu thị đồ thị : điểm, đường tròn, tam giác ....
            //LineItem curve2 = myPane.AddCurve("đường 2", list2, Color.Blue, SymbolType.None); //  Color màu Xanh, đặc trưng cho đường 2
            // ví dụ khoảng cách là 50ms 1 lần
            timer1.Interval = 1;
            //timer1.Enabled = true; // Kích hoạt cho timer1
            //timer1.Start(); // Chạy Timer1
            // Định hiện thị cho trục thời gian (Trục X)
            myPane.XAxis.Scale.Min = 0;  // Min  = 0;
            myPane.XAxis.Scale.Max = 200; // Mã  = 30;
            myPane.XAxis.Scale.MinorStep = 1;  // Đơn vị chia nhỏ nhất 1
            myPane.XAxis.Scale.MajorStep = 10; // Đơn vị chia lớn 5

            myPane.YAxis.Scale.Min = 0;
            myPane.YAxis.Scale.Max = 140;
            myPane.YAxis.Scale.MinorStep = 2;
            myPane.YAxis.Scale.MajorStep = 20;
            // Gọi hàm xác định cỡ trục
            zedGraphControl1.AxisChange();
            // Khởi động timer về vị trí ban đầu 
            tickStart = Environment.TickCount;
        }
        //=============================================================
        // Sự kiện khi nhấn nút Kết Nối
        //int check = 0;
        private void btKetNoi_Click(object sender, EventArgs e)
        {
            try
            {
                pause_time = false;
                P.Open();
                if (P.IsOpen)
                {
                    P.Write((cbDelay.SelectedIndex).ToString());
                }

                // Hiện thị Status
                status.ForeColor = Color.DarkMagenta;
                status.Text = "Đang kết nối với cổng " + cbCom.SelectedItem.ToString();
                btNgat.Enabled = true;
                btKetNoi.Enabled = false;
                btUpdate.Enabled = false;
                cbCom.Enabled = false;
                cbRate.Enabled = false;
                btDeleteGraph.Enabled = true;
                btExportGraph.Enabled = true;
                ketnoi = true;
                checkPause.Enabled = true;
                txtSampling.Text = sosanh_dem.ToString();
                btSamLing.Enabled = false;
                txtSampling.ReadOnly = true;
                //timer1.Enabled = true;
                //if (check == 0) { tickStart = Environment.TickCount; check = 1; }
                if (P.IsOpen)
                {
                    P.Write("a");
                }
            }
            catch (Exception ex)
            {
                status.ForeColor = Color.Red;
                MessageBox.Show("Không Kết Nối Được, Vui Lòng Kiểm Tra Cổng " + cbCom.SelectedItem.ToString(), "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btNgat.Enabled = false;
                btKetNoi.Enabled = true;
            }
        }
        //=============================================================
        //Sự kiện khi nhấn nút ngắt kết nối
        private void btNgat_Click(object sender, EventArgs e)
        {
            pause_time = true;
            NgatKetNoi();
        }
        //====================================
        //Chương trình con Ngắt Kết Noí
        public void NgatKetNoi()
        {
            if (P.IsOpen)
            {
                P.Write("b");
                P.Close();
            }
            status.ForeColor = Color.DarkMagenta;
            status.Text = "Đã ngắt kết nối";
            ketnoi = false;
            checkPause.Enabled = false;
            checkPause.Checked = false;
            btKetNoi.Enabled = true;
            btNgat.Enabled = false;
            btUpdate.Enabled = true;
            cbCom.Enabled = true;
            cbRate.Enabled = true;
            btExport.Enabled = true;
            btXoa.Enabled = true;
            btSamLing.Enabled = true;
            txtSampling.ReadOnly = false;
            txtadc.Text = "";
        }
        //=============================================================
        //Không cần quan tâm đến cái này
        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form2 frm = new Form2();
            frm.ShowDialog();
        }
        //============================================================
        //Sự kiện thoát
        private void thoátToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DialogResult kq = MessageBox.Show("Bạn muốn thoát chương trình?", "Thoát", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (kq == DialogResult.Yes)
            {
                if (P.IsOpen)
                {
                    P.Write("b");
                    for (i = 0; i <= 10000; i++) { };
                    P.Close();
                }
                this.Close();
            }
        }
        //================================================
        private void Form1_FormClosing(Object sender, FormClosingEventArgs e)
        {
            if (P.IsOpen)
            {
                P.Write("b");
                P.Close();
            }
        }
        //===========================
        //Sự kiện Update COM
        private void btUpdate_Click(object sender, EventArgs e)
        {
            cbCom.Items.Clear();
            string[] ports = SerialPort.GetPortNames();
            cbCom.Items.AddRange(ports);
            cbCom.SelectedIndex = 0;
        }
        //==========================================
        //Chương trình con xuất dữ liệu ra Excel
        private void ExportDataGridView_Excel(DataGridView dataGridView1, string file_name, string sheet_name, string title_name)
        {
            progressBar1.Maximum = dataGridView1.Rows.Count;

            Excel.ApplicationClass xlApp;
            Excel.Worksheet xlSheet;
            Excel.Workbook xlBook;
            //doi tuong Trống để thêm  vào xlApp sau đó lưu lại sau
            object missValue = System.Reflection.Missing.Value;
            //khoi tao doi tuong Com Excel moi
            xlApp = new Excel.ApplicationClass();
            xlBook = xlApp.Workbooks.Add(missValue);
            //su dung Sheet dau tien de thao tac
            xlSheet = (Excel.Worksheet)xlBook.Worksheets.get_Item(1);
            xlSheet.Name = sheet_name;
            //không cho hiện ứng dụng Excel lên để tránh gây đơ máy
            xlApp.Visible = false;
            xlApp.DisplayAlerts = false;
            string path = file_name;
            //--------------------------
            // Tạo title đầu tiên
            Excel.Range title = xlSheet.get_Range("A2", "C1");
            title.MergeCells = true;
            title.Value2 = title_name;
            title.Font.Bold = true;
            title.Font.Name = "Tahoma";
            title.Font.Size = "24";
            title.RowHeight = 20;
            title.Interior.ColorIndex = 25;//20=xanh dương nhat, 25=xanh dương dam, 30=nau,24-tim nhat nhat,23=xanh duong tuoi,22=cam,21=tim dam,15=den nhat
            title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
            title.VerticalAlignment = Excel.XlHAlign.xlHAlignCenter;
            //set  mau chu header
            title.Font.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Magenta);

            //thiet lap thuoc tinh cho cac Header
            Excel.Range header = xlSheet.get_Range("A3", "C3");
            header.Font.Name = "Tahoma";
            header.Font.Bold = true;
            header.Font.Size = 14;
            header.Interior.ColorIndex = 20;
            header.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
            header.VerticalAlignment = Excel.XlHAlign.xlHAlignCenter;
            header.RowHeight = 30;
            // Kẻ viền header
            header.Borders.LineStyle = Excel.Constants.xlSolid;

            //Freeze Top Row : Cố định dòng trong Excel
            Excel.Range myCell = (Excel.Range)xlSheet.Cells[4, 1];
            myCell.Activate();
            myCell.Application.ActiveWindow.FreezePanes = true;

            // storing header part in Excel
            for (cot = 0; cot < dataGridView1.Columns.Count; cot++)
            {
                xlSheet.Cells[3, cot + 1] = dataGridView1.Columns[cot].HeaderText;
            }
            // storing Each row and column value to excel sheet
            for (hang = 0; hang < dataGridView1.Rows.Count; hang++) // dataGridView1.Rows.Count-2 neu dòng cuối cùng sai giá trị neen khoong laays
            {
                for (cot = 0; cot < dataGridView1.Columns.Count; cot++)// khong lay gia tri cua cot cuoi cung trong dataGridView1 thì dataGridView1.Columns.Count - 1
                {
                    progressBar1.Value = hang + 1;

                    //dien gia tri vao cell
                    xlSheet.Cells[hang + 4, cot + 1] = dataGridView1.Rows[hang].Cells[cot].Value;
                    //autofit độ rộng cho các cột 
                    ((Excel.Range)xlSheet.Cells[hang + 4, cot + 1]).EntireColumn.AutoFit();
                    //Canh le cho cac hang
                    ((Excel.Range)xlSheet.Cells[hang + 4, cot + 1]).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    //font
                    ((Excel.Range)xlSheet.Cells[hang + 4, cot + 1]).Font.Name = "Tahoma";
                    //Size
                    ((Excel.Range)xlSheet.Cells[hang + 4, cot + 1]).Font.Size = 12;
                    //Ke duong vien
                    ((Excel.Range)xlSheet.Cells[hang + 4, cot + 1]).Borders.LineStyle = Excel.Constants.xlSolid;
                }
            }
            //--------------------------------------
            //save file
            xlBook.SaveAs(path, Excel.XlFileFormat.xlWorkbookNormal, missValue, missValue, missValue, missValue, Excel.XlSaveAsAccessMode.xlExclusive, missValue, missValue, missValue, missValue, missValue);
            xlBook.Close(true, missValue, missValue);
            xlApp.Quit();
            // release cac doi tuong COM
            releaseObject(xlSheet);
            releaseObject(xlBook);
            releaseObject(xlApp);
            //MessageBox.Show("Đã xuất ra file excel trong ổ " + path);
        }
        //===============================
        static public void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                throw new Exception("Exception Occured while releasing object " + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }
        //=========================
        //Chương trình con Xuất file ảnh đồ thị
        private void ExportGraph()
        {
            //create Bitmap recipient
            Bitmap bm = new Bitmap(1, 1);
            //measure the chart to size the bitmap
            using (Graphics g = Graphics.FromImage(bm))
                this.zedGraphControl1.GraphPane.AxisChange(g);
            //save the file of the chart on disk (PNG format)
            this.zedGraphControl1.GraphPane.GetImage().Save("D:\\Noise Level_" + file_thoigian + ".png", System.Drawing.Imaging.ImageFormat.Png);
        }
        //=============================================
        private void btExportGraph_Click(object sender, EventArgs e)
        {
            // Hiện thị Status
            progressBar1.Value = progressBar1.Minimum;
            status.ForeColor = Color.Red;
            status.Text = "Đang xuất file excel ... ... ... Vui lòng chờ cho đến khi hoàn thành!";
            ExportGraph();
            status.ForeColor = Color.DarkMagenta;
            status.Text = "Đã xuất ra file ảnh đồ thị trong ổ " + "D:\\Noise Level_" + file_thoigian + ".png";
            progressBar1.Value = progressBar1.Maximum;
        }
        //============================
        //Sự kiện nhấn nút Export Excel
        private void btExport_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0)
            {
                //if (ketnoi == true)
                //{
                //    DialogResult kq = MessageBox.Show("Kết Nối Sẽ Ngắt Khi Xuất File Excel, Bạn Có muốn Tiếp Tục ?", "Thông Báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                //    if (kq == DialogResult.Yes)
                //    {
                //        NgatKetNoi();
                //        Export();
                //    }
                //}
                //else
                //{
                if (ketnoi == true)
                    checkPause.Checked = true;
                Export();
                //}
            }
            else
                MessageBox.Show("Chưa Có Dữ Liệu", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        //=============================
        public void Export()
        {
            // Hiện thị Status
            status.ForeColor = Color.Red;
            status.Text = "Đang xuất file excel ... ... ... Vui lòng chờ cho đến khi hoàn thành!";
            ExportDataGridView_Excel(dataGridView1, "D:\\Noise Level_" + file_thoigian, "Data", "Noise Level Meter");
            status.ForeColor = Color.DarkMagenta;
            status.Text = "Đã xuất ra file excel trong ổ " + "D:\\Noise Level_" + file_thoigian;
        }
        //=================================================
        //Sự kiện khi nhấn nút xóa
        private void btXoa_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0)
            {
                DialogResult kq = MessageBox.Show("Bạn muốn xóa tất cả dữ liệu!", "Cảnh Báo", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                if (kq == DialogResult.Yes)
                {
                    if (ketnoi == true)
                        checkPause.Checked = true;
                    status.ForeColor = Color.Red;
                    status.Text = "Đang xóa dữ liệu ... ... ...Vui lòng chờ cho đến khi xóa xong!";
                    //btExport.Enabled = false;
                    Remove_DataGridView();
                    //btXoa.Enabled = false;
                    txtadc.Text = "";
                    counter = 0;
                    txtSampling.Text = sosanh_dem.ToString();
                    txtCounter.Text = counter.ToString();
                    status.ForeColor = Color.DarkMagenta;
                    status.Text = "Xóa dữ liệu thành công!";
                }
            }
            else
            {
                MessageBox.Show("Chưa Có Dữ Liệu", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        //============================================
        //Chương trình con xóa dữ liệu
        public void Remove_DataGridView()
        {
            progressBar1.Maximum = dataGridView1.Rows.Count;
            while (dataGridView1.Rows.Count >= 1)
            {
                dataGridView1.Rows.RemoveAt(dataGridView1.Rows.Count - 1);

                if (dataGridView1.Rows.Count > 1)
                    progressBar1.Value = dataGridView1.Rows.Count - 1;
            }
            progressBar1.Value = 0;
        }
        //===============================
        //Sự kiện lấy mẫu
        private void btSamLing_Click(object sender, EventArgs e)
        {
            if (txtSampling.Text != sosanh_dem.ToString())
            {
                bool kiemtra; int tam;
                kiemtra = Int32.TryParse(txtSampling.Text, out tam);
                if (kiemtra == false || tam < 2 || tam > 2000000000)
                {
                    MessageBox.Show("Giá Trị Nhập Phải Nằm Trong Khoảng [2 - 2000000000]", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    txtSampling.Text = sosanh_dem.ToString();
                }
                else
                {
                    DialogResult kq = MessageBox.Show("Bạn Muốn Cập Nhật Số Lượng Lấy Mẫu Tối Đa Là: " + tam.ToString() + " Mẫu", "Thông Báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (kq == DialogResult.Yes)
                    {
                        sosanh_dem = tam;
                        txtSampling.Text = tam.ToString();

                        progressBar1.Minimum = 0;
                        //giam so dong dataGridView1
                        progressBar1.Maximum = dataGridView1.Rows.Count;
                        while (dataGridView1.Rows.Count > sosanh_dem)
                        {
                            dataGridView1.Rows.RemoveAt(dataGridView1.Rows.Count - 1);
                            counter--;
                            if (dataGridView1.Rows.Count > 1)
                                progressBar1.Value = dataGridView1.Rows.Count - 1;
                        }
                        progressBar1.Value = 0;
                        txtCounter.Text = counter.ToString();
                        txtSampling.Text = sosanh_dem.ToString();
                    }
                    else
                    {
                        txtSampling.Text = sosanh_dem.ToString();
                    }
                }

            }
        }
        //================================
        //Sự kiện tạm dừng nhận dữ liệu
        private void checkPause_CheckedChanged(object sender, EventArgs e)
        {
            txtSampling.Text = sosanh_dem.ToString();
            if (checkPause.Checked == true)
            {
                checkPause.ForeColor = Color.Red;
                bien_pause = false;
                //btExport.Enabled = true;
                //btXoa.Enabled = true;
                btSamLing.Enabled = true;
                txtSampling.ReadOnly = false;
                //btKetNoi.Enabled = false;
                //btNgat.Enabled = true;
                txtadc.Text = "";
                if (P.IsOpen)
                {
                    P.Write("b");
                }
                status.ForeColor = Color.DarkMagenta;
                //timer1.Enabled = false;
                status.Text = "Tạm dừng nhận dữ liệu";
            }
            else
            {
                btSamLing.Enabled = false;
                txtSampling.ReadOnly = true;
                checkPause.ForeColor = Color.Navy;
                bien_pause = true;
                btExportGraph.Enabled = true;
                btSamLing.Enabled = false;
                txtSampling.ReadOnly = true;
                txtadc.Text = "";
                //btNgat.Enabled = true;
                if (P.IsOpen)
                {
                    P.Write("a");
                }
                status.ForeColor = Color.DarkMagenta;
                //timer1.Enabled = true;
                status.Text = "Đang kết nối với cổng " + cbCom.SelectedItem.ToString();
            }
        }
        ////////////////////////////////////////////////////////////////
        //Sự kiện mở thư mục chứa file Excel lưu dữ liệu
        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string Path = "D:\\"; // tên đường dẫn tơi thư mục bạn muốn mở 
            Process.Start(@"D:\", Path);
        }

        //======================================
        // Để tiện cho việc sử dụng chúng ta sẽ xây dựng 1 hàm draw phục vụ cho việc vẽ đồ thị
        public void DrawChart(double setpoint1, double setpoint2) // Ở ví dụ này chúng ta có 2 đường
        {

            if (zedGraphControl1.GraphPane.CurveList.Count <= 0)
                return;
            // Kiểm tra việc khởi tạo các đường curve
            // Đưa về điểm xuất phát
            curve1 = zedGraphControl1.GraphPane.CurveList[0] as LineItem;
            //LineItem curve2 = zedGraphControl1.GraphPane.CurveList[1] as LineItem;
            if (curve1 == null)
                return;
            //if (curve2 == null)
            //    return;

            // list chứa các điểm. 
            // Get the PointPairList
            list1 = curve1.Points as IPointListEdit;
            //IPointListEdit list2 = curve2.Points as IPointListEdit;

            if (list1 == null)
                return;
            //if (list2 == null)
            //    return;

            // Time được tính bằng ms
            if (pause_time == false)
                //time = (Environment.TickCount - tickStart) / 1000.0;
                time = time + delay;


            // Tính toán giá trị hiện thị

            // Muốn hiện thị cái gì thì chỉ việc thay vào setpointx
            //list1.Add(time, setpoint1); // Đây chính là hàm hiển thị dữ liệu của mình lên đồ thị
            // list2.Add(time, setpoint2); // Đây chính là hàm hiển thị dữ liệu của mình lên đồ thị

            // Ko vẽ setpoint2 mà thử vẽ đồ thị hình sin với 3 seconds per cycle
            //list2.Add(time, Math.Sin(2.0 * Math.PI * time / 3.0));
            convert = Double.TryParse(luudb, out luugiatri);
            if (convert != false)
            {
                list1.Add(time, luugiatri);
            }

            //for (int i=0;i<=20;i++)
            //{
            //    //list2.Add(time, dataGridView1.Rows[i].Cells[2].Value);
            //    list2.Add(time, 12.3);
            //}

            // đoạn chương trình thực hiện vẽ đồ thị
            xScale = zedGraphControl1.GraphPane.XAxis.Scale;
            if (time > xScale.Max - xScale.MajorStep)
            {
                xScale.Max = time + xScale.MajorStep;
                xScale.Min = xScale.Max - 30.0; // Timer chạy qua 30 sẽ tự động dịch chuyển tịnh tiến sang trái
                //Nếu ko muốn dịch chuyển mà chạy bắt đầu từ 0 thì : xScale.Min = 0;
                if (btCompactScroll.Text == "Compact")
                {
                    xScale.Max = time + xScale.MajorStep;
                    xScale.Min = xScale.Max - 200.0;
                }
                else
                {
                    xScale.Max = time + xScale.MajorStep;
                    xScale.Min = 0;
                }
            }
            // Vẽ đồ thị
            zedGraphControl1.AxisChange();
            // Force a redraw
            zedGraphControl1.Invalidate();
        }
        //=================================
        //int check = 0; // để cho khi nhấn Start là sẽ bắt đầu từ điểm 0
        //private void btStartStop_Click(object sender, EventArgs e)
        //{
        //    if (btStartStop.Text == "Start")
        //    {
        //        timer1.Enabled = true;
        //        btStartStop.Text = "Stop";
        //        // Khởi động timer về vị trí ban đầu 
        //        if (check == 0) { tickStart = Environment.TickCount; check = 1; }
        //    }
        //    else
        //    {
        //        timer1.Enabled = false;
        //        btStartStop.Text = "Start";
        //    }
        //}

        //=================================
        private void btCompactScroll_Click(object sender, EventArgs e)
        {
            if (btCompactScroll.Text == "Compact") btCompactScroll.Text = "Scroll";
            else btCompactScroll.Text = "Compact";
        }
        //===============================
        //Đồng hồ thời gian
        private void timer1_Tick(object sender, EventArgs e)
        {
            thoigian = DateTime.Now.ToString("dd/MM/yyyy_HH:mm:ss:fff");
            file_thoigian = DateTime.Now.ToString("dd-MM-yyyy_HH-mm-ss");
            textBox1.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void btDeleteGraph_Click(object sender, EventArgs e)
        {
            if (zedGraphControl1.GraphPane.CurveList.Count <= 0)
            {
                MessageBox.Show("Chưa Vẽ Đồ Thị", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                DialogResult kq = MessageBox.Show("Bạn muốn xóa đồ thị !", "Cảnh Báo", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                if (kq == DialogResult.Yes)
                {

                    if (ketnoi == true)
                        checkPause.Checked = true;
                    btExportGraph.Enabled = false;
                    status.ForeColor = Color.Red;
                    status.Text = "Đang xóa đồ thị ...Vui lòng chờ cho đến khi xóa xong!";
                    progressBar1.Value = progressBar1.Minimum;

                    time = -delay;
                    list1.Clear();
                    //list.Clear();

                    myPane.XAxis.Scale.Min = 0;
                    myPane.XAxis.Scale.Max = 200;
                    //myPane.XAxis.Scale.MinorStep = 1;  // Đơn vị chia nhỏ nhất 1
                    //myPane.XAxis.Scale.MajorStep = 10; // Đơn vị chia lớn 5

                    // Gọi hàm xác định cỡ trục
                    //zedGraphControl1.AxisChange();
                    // Khởi động timer về vị trí ban đầu 
                    tickStart = Environment.TickCount;
                    DrawChart(20, 0);
                    //zedGraphControl1.Invalidate();
                    //KhoiTaoZedGraph();

                    status.ForeColor = Color.DarkMagenta;
                    status.Text = "Xóa đồ thị thành công!";
                    progressBar1.Value = progressBar1.Maximum;
                }
            }
        }



    }
}






