namespace GTMT_SOUND
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.status = new System.Windows.Forms.ToolStripStatusLabel();
            this.menu = new System.Windows.Forms.MenuStrip();
            this.thoátToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label6 = new System.Windows.Forms.Label();
            this.cbCom = new System.Windows.Forms.ComboBox();
            this.cbRate = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btDeleteGraph = new System.Windows.Forms.Button();
            this.btCompactScroll = new System.Windows.Forms.Button();
            this.cbDelay = new System.Windows.Forms.ComboBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txtCounter = new System.Windows.Forms.TextBox();
            this.checkPause = new System.Windows.Forms.CheckBox();
            this.btSamLing = new System.Windows.Forms.Button();
            this.txtSampling = new System.Windows.Forms.TextBox();
            this.btExportGraph = new System.Windows.Forms.Button();
            this.btExport = new System.Windows.Forms.Button();
            this.btUpdate = new System.Windows.Forms.Button();
            this.btXoa = new System.Windows.Forms.Button();
            this.btNgat = new System.Windows.Forms.Button();
            this.btKetNoi = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtadc = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.zedGraphControl1 = new ZedGraph.ZedGraphControl();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.number = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.times = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.noise_data = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.statusStrip1.SuspendLayout();
            this.menu.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dateTimePicker1
            // 
            resources.ApplyResources(this.dateTimePicker1, "dateTimePicker1");
            this.dateTimePicker1.Name = "dateTimePicker1";
            // 
            // statusStrip1
            // 
            this.statusStrip1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.status});
            resources.ApplyResources(this.statusStrip1, "statusStrip1");
            this.statusStrip1.Name = "statusStrip1";
            // 
            // status
            // 
            this.status.ActiveLinkColor = System.Drawing.Color.Red;
            this.status.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            resources.ApplyResources(this.status, "status");
            this.status.ForeColor = System.Drawing.Color.Red;
            this.status.LinkColor = System.Drawing.Color.Maroon;
            this.status.Name = "status";
            // 
            // menu
            // 
            this.menu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.thoátToolStripMenuItem,
            this.openToolStripMenuItem,
            this.aboutToolStripMenuItem});
            resources.ApplyResources(this.menu, "menu");
            this.menu.Name = "menu";
            // 
            // thoátToolStripMenuItem
            // 
            resources.ApplyResources(this.thoátToolStripMenuItem, "thoátToolStripMenuItem");
            this.thoátToolStripMenuItem.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.thoátToolStripMenuItem.Name = "thoátToolStripMenuItem";
            this.thoátToolStripMenuItem.Click += new System.EventHandler(this.thoátToolStripMenuItem_Click);
            // 
            // openToolStripMenuItem
            // 
            resources.ApplyResources(this.openToolStripMenuItem, "openToolStripMenuItem");
            this.openToolStripMenuItem.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.openToolStripMenuItem.Name = "openToolStripMenuItem";
            this.openToolStripMenuItem.Click += new System.EventHandler(this.openToolStripMenuItem_Click);
            // 
            // aboutToolStripMenuItem
            // 
            resources.ApplyResources(this.aboutToolStripMenuItem, "aboutToolStripMenuItem");
            this.aboutToolStripMenuItem.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Click += new System.EventHandler(this.aboutToolStripMenuItem_Click);
            // 
            // label6
            // 
            resources.ApplyResources(this.label6, "label6");
            this.label6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(0)))));
            this.label6.Name = "label6";
            // 
            // cbCom
            // 
            this.cbCom.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.cbCom.FormattingEnabled = true;
            resources.ApplyResources(this.cbCom, "cbCom");
            this.cbCom.Name = "cbCom";
            this.cbCom.SelectedIndexChanged += new System.EventHandler(this.cbCom_SelectedIndexChanged);
            // 
            // cbRate
            // 
            this.cbRate.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.cbRate.FormattingEnabled = true;
            resources.ApplyResources(this.cbRate, "cbRate");
            this.cbRate.Name = "cbRate";
            this.cbRate.SelectedIndexChanged += new System.EventHandler(this.cbRate_SelectedIndexChanged);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.ForeColor = System.Drawing.Color.Yellow;
            this.label1.Name = "label1";
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.ForeColor = System.Drawing.Color.Yellow;
            this.label2.Name = "label2";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btDeleteGraph);
            this.groupBox1.Controls.Add(this.btCompactScroll);
            this.groupBox1.Controls.Add(this.cbDelay);
            this.groupBox1.Controls.Add(this.label8);
            this.groupBox1.Controls.Add(this.txtCounter);
            this.groupBox1.Controls.Add(this.checkPause);
            this.groupBox1.Controls.Add(this.btSamLing);
            this.groupBox1.Controls.Add(this.txtSampling);
            this.groupBox1.Controls.Add(this.btExportGraph);
            this.groupBox1.Controls.Add(this.btExport);
            this.groupBox1.Controls.Add(this.btUpdate);
            this.groupBox1.Controls.Add(this.btXoa);
            this.groupBox1.Controls.Add(this.cbRate);
            this.groupBox1.Controls.Add(this.cbCom);
            this.groupBox1.Controls.Add(this.btNgat);
            this.groupBox1.Controls.Add(this.btKetNoi);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.groupBox2);
            resources.ApplyResources(this.groupBox1, "groupBox1");
            this.groupBox1.ForeColor = System.Drawing.Color.Yellow;
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.TabStop = false;
            // 
            // btDeleteGraph
            // 
            this.btDeleteGraph.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btDeleteGraph, "btDeleteGraph");
            this.btDeleteGraph.ForeColor = System.Drawing.Color.Navy;
            this.btDeleteGraph.Name = "btDeleteGraph";
            this.btDeleteGraph.UseVisualStyleBackColor = false;
            this.btDeleteGraph.Click += new System.EventHandler(this.btDeleteGraph_Click);
            // 
            // btCompactScroll
            // 
            this.btCompactScroll.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btCompactScroll, "btCompactScroll");
            this.btCompactScroll.ForeColor = System.Drawing.Color.Navy;
            this.btCompactScroll.Name = "btCompactScroll";
            this.btCompactScroll.UseVisualStyleBackColor = false;
            this.btCompactScroll.Click += new System.EventHandler(this.btCompactScroll_Click);
            // 
            // cbDelay
            // 
            this.cbDelay.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.cbDelay.FormattingEnabled = true;
            resources.ApplyResources(this.cbDelay, "cbDelay");
            this.cbDelay.Name = "cbDelay";
            this.cbDelay.SelectedIndexChanged += new System.EventHandler(this.cbDelay_SelectedIndexChanged);
            // 
            // label8
            // 
            resources.ApplyResources(this.label8, "label8");
            this.label8.ForeColor = System.Drawing.Color.Yellow;
            this.label8.Name = "label8";
            // 
            // txtCounter
            // 
            resources.ApplyResources(this.txtCounter, "txtCounter");
            this.txtCounter.Name = "txtCounter";
            this.txtCounter.ReadOnly = true;
            // 
            // checkPause
            // 
            resources.ApplyResources(this.checkPause, "checkPause");
            this.checkPause.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.checkPause.ForeColor = System.Drawing.Color.Navy;
            this.checkPause.Name = "checkPause";
            this.checkPause.UseVisualStyleBackColor = false;
            this.checkPause.CheckedChanged += new System.EventHandler(this.checkPause_CheckedChanged);
            // 
            // btSamLing
            // 
            this.btSamLing.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btSamLing, "btSamLing");
            this.btSamLing.ForeColor = System.Drawing.Color.Navy;
            this.btSamLing.Name = "btSamLing";
            this.btSamLing.UseVisualStyleBackColor = false;
            this.btSamLing.Click += new System.EventHandler(this.btSamLing_Click);
            // 
            // txtSampling
            // 
            resources.ApplyResources(this.txtSampling, "txtSampling");
            this.txtSampling.Name = "txtSampling";
            // 
            // btExportGraph
            // 
            this.btExportGraph.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btExportGraph, "btExportGraph");
            this.btExportGraph.ForeColor = System.Drawing.Color.Navy;
            this.btExportGraph.Name = "btExportGraph";
            this.btExportGraph.UseVisualStyleBackColor = false;
            this.btExportGraph.Click += new System.EventHandler(this.btExportGraph_Click);
            // 
            // btExport
            // 
            this.btExport.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btExport, "btExport");
            this.btExport.ForeColor = System.Drawing.Color.Navy;
            this.btExport.Name = "btExport";
            this.btExport.UseVisualStyleBackColor = false;
            this.btExport.Click += new System.EventHandler(this.btExport_Click);
            // 
            // btUpdate
            // 
            this.btUpdate.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btUpdate, "btUpdate");
            this.btUpdate.ForeColor = System.Drawing.Color.Navy;
            this.btUpdate.Name = "btUpdate";
            this.btUpdate.UseVisualStyleBackColor = false;
            this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
            // 
            // btXoa
            // 
            this.btXoa.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btXoa, "btXoa");
            this.btXoa.ForeColor = System.Drawing.Color.Navy;
            this.btXoa.Name = "btXoa";
            this.btXoa.UseVisualStyleBackColor = false;
            this.btXoa.Click += new System.EventHandler(this.btXoa_Click);
            // 
            // btNgat
            // 
            this.btNgat.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btNgat, "btNgat");
            this.btNgat.ForeColor = System.Drawing.Color.Navy;
            this.btNgat.Name = "btNgat";
            this.btNgat.UseVisualStyleBackColor = false;
            this.btNgat.Click += new System.EventHandler(this.btNgat_Click);
            // 
            // btKetNoi
            // 
            this.btKetNoi.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            resources.ApplyResources(this.btKetNoi, "btKetNoi");
            this.btKetNoi.ForeColor = System.Drawing.Color.Navy;
            this.btKetNoi.Name = "btKetNoi";
            this.btKetNoi.UseVisualStyleBackColor = false;
            this.btKetNoi.Click += new System.EventHandler(this.btKetNoi_Click);
            // 
            // label7
            // 
            resources.ApplyResources(this.label7, "label7");
            this.label7.ForeColor = System.Drawing.Color.Yellow;
            this.label7.Name = "label7";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.txtadc);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            resources.ApplyResources(this.groupBox2, "groupBox2");
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.TabStop = false;
            // 
            // txtadc
            // 
            this.txtadc.BackColor = System.Drawing.Color.Gainsboro;
            this.txtadc.Cursor = System.Windows.Forms.Cursors.IBeam;
            resources.ApplyResources(this.txtadc, "txtadc");
            this.txtadc.ForeColor = System.Drawing.Color.Red;
            this.txtadc.Name = "txtadc";
            this.txtadc.ReadOnly = true;
            this.txtadc.Tag = "";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.ForeColor = System.Drawing.Color.Yellow;
            this.label4.Name = "label4";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.ForeColor = System.Drawing.Color.Yellow;
            this.label3.Name = "label3";
            // 
            // progressBar1
            // 
            resources.ApplyResources(this.progressBar1, "progressBar1");
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Step = 1;
            // 
            // textBox1
            // 
            resources.ApplyResources(this.textBox1, "textBox1");
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // zedGraphControl1
            // 
            resources.ApplyResources(this.zedGraphControl1, "zedGraphControl1");
            this.zedGraphControl1.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.zedGraphControl1.BackColor = System.Drawing.Color.Black;
            this.zedGraphControl1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.zedGraphControl1.Cursor = System.Windows.Forms.Cursors.Default;
            this.zedGraphControl1.EditButtons = System.Windows.Forms.MouseButtons.None;
            this.zedGraphControl1.ForeColor = System.Drawing.Color.Black;
            this.zedGraphControl1.Name = "zedGraphControl1";
            this.zedGraphControl1.PanButtons2 = System.Windows.Forms.MouseButtons.Left;
            this.zedGraphControl1.ScrollGrace = 0;
            this.zedGraphControl1.ScrollMaxX = 0;
            this.zedGraphControl1.ScrollMaxY = 0;
            this.zedGraphControl1.ScrollMaxY2 = 0;
            this.zedGraphControl1.ScrollMinX = 0;
            this.zedGraphControl1.ScrollMinY = 0;
            this.zedGraphControl1.ScrollMinY2 = 0;
            this.zedGraphControl1.ZoomButtons = System.Windows.Forms.MouseButtons.None;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.dataGridView1);
            resources.ApplyResources(this.groupBox3, "groupBox3");
            this.groupBox3.ForeColor = System.Drawing.Color.Yellow;
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.TabStop = false;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToOrderColumns = true;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dataGridView1.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dataGridView1.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.DisplayedCells;
            this.dataGridView1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.Sunken;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.number,
            this.times,
            this.noise_data});
            this.dataGridView1.GridColor = System.Drawing.Color.Blue;
            resources.ApplyResources(this.dataGridView1, "dataGridView1");
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.Single;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dataGridView1.RowsDefaultCellStyle = dataGridViewCellStyle5;
            // 
            // number
            // 
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Times New Roman", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.Black;
            this.number.DefaultCellStyle = dataGridViewCellStyle2;
            resources.ApplyResources(this.number, "number");
            this.number.Name = "number";
            this.number.ReadOnly = true;
            this.number.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // times
            // 
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Times New Roman", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.Color.Black;
            this.times.DefaultCellStyle = dataGridViewCellStyle3;
            resources.ApplyResources(this.times, "times");
            this.times.Name = "times";
            this.times.ReadOnly = true;
            this.times.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // noise_data
            // 
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle4.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.Color.Black;
            this.noise_data.DefaultCellStyle = dataGridViewCellStyle4;
            this.noise_data.FillWeight = 200F;
            resources.ApplyResources(this.noise_data, "noise_data");
            this.noise_data.Name = "noise_data";
            this.noise_data.ReadOnly = true;
            this.noise_data.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            // 
            // Form1
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoValidate = System.Windows.Forms.AutoValidate.EnablePreventFocusChange;
            this.BackColor = System.Drawing.Color.Navy;
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.zedGraphControl1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.dateTimePicker1);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menu);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.groupBox3);
            this.ForeColor = System.Drawing.Color.Black;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
            this.MainMenuStrip = this.menu;
            this.Name = "Form1";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.Load += new System.EventHandler(this.Form1_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.menu.ResumeLayout(false);
            this.menu.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel status;
        private System.Windows.Forms.MenuStrip menu;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cbCom;
        private System.Windows.Forms.ComboBox cbRate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btKetNoi;
        private System.Windows.Forms.Button btNgat;
        private System.Windows.Forms.Button btXoa;
        private System.Windows.Forms.ToolStripMenuItem thoátToolStripMenuItem;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btUpdate;
        private System.Windows.Forms.Button btExport;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.TextBox txtSampling;
        private System.Windows.Forms.Button btSamLing;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.CheckBox checkPause;
        private System.Windows.Forms.TextBox txtCounter;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox cbDelay;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.ToolStripMenuItem openToolStripMenuItem;
        private System.Windows.Forms.Button btCompactScroll;
        private ZedGraph.ZedGraphControl zedGraphControl1;
        private System.Windows.Forms.Button btExportGraph;
        private System.Windows.Forms.TextBox txtadc;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btDeleteGraph;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DataGridViewTextBoxColumn number;
        private System.Windows.Forms.DataGridViewTextBoxColumn times;
        private System.Windows.Forms.DataGridViewTextBoxColumn noise_data;
    }
}

