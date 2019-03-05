using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace ASPDOTNETCoreService
{
    public class Program
    {
        public const int HttpPort = 12020;
        public const int HttpsPort = 12021;
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>();
        public static IWebHost BuildWebHost(string[] args)
        {
            X509Certificate2 cert = CreateSSLCertificate();
            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .UseKestrel(options =>
                {
                    options.Listen(IPAddress.Any, HttpPort);
                    if (cert != null) options.Listen(IPAddress.Any, HttpsPort, listenOptions =>
                    {
                        listenOptions.UseHttps(cert);
                    });
                })
                .Build();
        }
        private static X509Certificate2 CreateSSLCertificate()
        {
            X509Certificate2 cert = null;
            try
            {
                cert = new X509Certificate2("testcert.pfx", "Monkey123",
                    X509KeyStorageFlags.UserKeySet);
                Console.WriteLine($"{cert.FriendlyName} ({ cert.IssuerName.Name}) created.");
            }
            catch (Exception e)
            {
                Console.WriteLine($"Unable to create certificate in user store: {e}");
            }

            return cert;
        }
    }
}
