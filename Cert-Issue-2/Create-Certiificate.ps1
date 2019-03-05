# create a self signed certificate

new-selfsignedcertificate -DnsName "example.com" -CertStoreLocation "cert:\CurrentUser\My" `
            -FriendlyName "Test Certificate" -Subject "A Test Certificate"


$cert = (Get-ChildItem -Path cert:\CurrentUser\My -DNSName "example.com")

# create a secure string password

# $mypwd = Read-Host 'Enter password for certificate PFX file: ' -AsSecureString
$mypwd = ConvertTo-SecureString -String "Monkey123" -AsPlainText -Force

# export pfx image

export-pfxcertificate -cert $cert[0] -filepath testcert.pfx -Password $mypwd -Force

