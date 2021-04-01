<center>
    <h1 align="center">BlockTheSpot</h1>
    <h4 align="center">A multi-purpose adblocker and skip-bypass for the <strong>Windows</strong> Spotify desktop application.</h4>
    <p align="center">
        <strong>Last updated:</strong> 24 March 2020<br>
        <strong>Last tested version:</strong> 1.1.56.595.g2d2da0de
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

:warning: This mod is for the [**Desktop Application**](https://www.spotify.com/download/windows/) of Spotify on Windows only and **not the Microsoft Store version**.

#### Installation/Update:
* Just download and run [BlockTheSpot.bat](https://raw.githubusercontent.com/Daksh777/BlockTheSpot/master/BlockTheSpot.bat)
* Enter 'Y' when prompted to swap Alpha UI to Old UI if needed.
or
1. Browse to your Spotify installation folder `%APPDATA%\Spotify`
2. Download `chrome_elf.zip` from [releases](https://github.com/mrpond/BlockTheSpot/releases)
3. Unzip and replace `chrome_elf.dll` and `config.ini` 

#### Uninstall:
* Just run [uninstall.bat](https://raw.githubusercontent.com/Daksh777/BlockTheSpot/master/uninstall.bat)
or
* Reinstall Spotify 

#### Known Issues:  
* BlockTheSpot will have issues blocking ads on the alpha version of Spotify. To identify this, look into the Spotify version and see if there is `-a` in the end. If so, you have an alpha version of Spotify. To be able to use BlockTheSpot, [click here](http://download.spotify.com/SpotifyFullSetup.exe) to download the latest Spotify stable/public version.  
* Optional feature "Remove Upgrade Button" will not work with Spicetify, also might have issues with alpha Spotify.  
* It will also have issues with the latest Spotify version where the user avatar will be blank.   

#### Note:
* "chrome_elf.dll" gets replaced by the Spotify installer each time it updates, make sure to replace it after an update.  
* Spicetify users have to reapply BlockTheSpot after applying a Spicetify theme.  
* The ad banner may appear if your network uses [Web Proxy Auto-Discovery Protocol](https://en.wikipedia.org/wiki/Web_Proxy_Auto-Discovery_Protocol)
    * Setting `Skip_wpad = 1` in config.ini may help
* For Spotify Premium users, setting `Block_BannerOnly = 1` will only block the banner at home