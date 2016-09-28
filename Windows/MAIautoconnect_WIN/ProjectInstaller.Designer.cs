namespace MAIautoconnect_WIN
{
    partial class ProjectInstaller
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

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.serviceProcessConnectInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.serviceConnectInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // serviceProcessConnectInstaller
            // 
            this.serviceProcessConnectInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.serviceProcessConnectInstaller.Password = null;
            this.serviceProcessConnectInstaller.Username = null;
            // 
            // serviceConnectInstaller
            // 
            this.serviceConnectInstaller.Description = "Powered by Corrupted Project. ";
            this.serviceConnectInstaller.DisplayName = "MAIautoconnect_WIN";
            this.serviceConnectInstaller.ServiceName = "MAIautoconnectServive";
            this.serviceConnectInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.serviceProcessConnectInstaller,
            this.serviceConnectInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller serviceProcessConnectInstaller;
        private System.ServiceProcess.ServiceInstaller serviceConnectInstaller;
    }
}