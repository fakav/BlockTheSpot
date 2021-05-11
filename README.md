<center>
    <h1 align="center">BlockTheSpot</h1>
    <h4 align="center">A multi-purpose adblocker and skip-bypass for the <strong>Windows</strong> Spotify desktop application.</h4>
    <p align="center">
        <strong>Last updated:</strong> 21 April 2021<br>
        <strong>Last tested version:</strong> 1.1.59.710.g134abcca-a
    </p> 
</center>

#### Important checks before installing:
0. Update Windows, update Spotify and update BlockTheSpot
1. Go to "Windows Security" -> "Virus & Threat Protection"
2. Click "Allowed threats" -> "Remove all allowed threats"

### Features:
* Blocks all banner/video/audio ads within the app
* Retains friend, vertical video and radio functionality
* Unlocks the skip function for any track  
* Now supports the new Alpha version (New UI)  

:warning: This mod is for the [**Desktop Application**](https://www.spotify.com/download/windows/) of Spotify on Windows only and **not the Microsoft Store version**.

#### Installation/Update:
* Just download and run [BlockTheSpot.bat](https://raw.githubusercontent.com/Daksh777/BlockTheSpot/master/BlockTheSpot.bat)
* Enter 'Y' when prompted to swap Alpha UI to Old UI if needed. <br>

or <br>

* Browse to your Spotify installation folder `%APPDATA%\Spotify`
* Download `chrome_elf.zip` from [releases](https://github.com/mrpond/BlockTheSpot/releases)
* Unzip and replace `chrome_elf.dll` and `config.ini` 

#### Uninstall:
* Just run [uninstall.bat](https://raw.githubusercontent.com/Daksh777/BlockTheSpot/master/uninstall.bat) <br>

or <br>

* Reinstall Spotify 

#### Known Issues:    
* The user avatar will be blank, Check [#83](https://github.com/mrpond/BlockTheSpot/issues/83) for more info.   
* The new UI will have black banner without ads. See [#150](https://github.com/mrpond/BlockTheSpot/issues/150)

#### Note:
* "chrome_elf.dll" gets replaced by the Spotify installer each time it updates, make sure to replace it after an update.  
* Spicetify users have to reapply BlockTheSpot after applying a Spicetify theme.  
* The ad banner may appear if your network uses [Web Proxy Auto-Discovery Protocol](https://en.wikipedia.org/wiki/Web_Proxy_Auto-Discovery_Protocol)
    * Setting `Skip_wpad = 1` in config.ini may help
* For Spotify Premium users, setting `Block_BannerOnly = 1` will only block the banner at home
