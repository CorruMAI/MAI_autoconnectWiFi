using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceProcess;
using System.Threading;
using SimpleWifi;
using System.Net;

namespace MAIautoconnect_WIN
{
    public partial class MAIautocinnectServive : ServiceBase
    {
        private static Wifi wifi;
        public MAIautocinnectServive()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            Thread infConnectThread = new Thread(infConnector);
            infConnectThread.Start();
        }

        protected override void OnStop()
        {
        }
        private static bool Status()
        {
            Console.WriteLine("\r\n-- CONNECTION STATUS --");
            if (wifi.ConnectionStatus == WifiStatus.Connected)
            {
                Console.WriteLine("You are connected to a wifi");
                return true;
            }
            else
                Console.WriteLine("You are not connected to a wifi");
            return false;
        }

        private static bool List()
        {
            Console.WriteLine("\r\n-- Access point list --");
            IEnumerable<AccessPoint> accessPoints = wifi.GetAccessPoints().OrderByDescending(ap => ap.SignalStrength);

            foreach (AccessPoint ap in accessPoints)
            {
                if (ap.IsConnected)
                    Console.WriteLine("Current connection: {0}.", ap.Name);
                if (ap.Name == "MAInet_public" && ap.IsConnected)
                    return true;
            }
            return false;
        }

        static void infConnector()
        {
            wifi = new Wifi();
            while (true)
            {
                if (Status() && List())
                {
                    Console.WriteLine("connecting");
                    try
                    {
                        string site = "http://1.1.1.1/login.html?network_name=Guest+Network&username=mai&password=1930&buttonClicked=4";
                        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(site);
                        req.Timeout = 3 * 1000;
                        req.GetResponse().Close();
                        Console.WriteLine("Done. Response has been sent.");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                    }
                }
                Thread.Sleep(5 * 1000);
            }
        }
    }
}

