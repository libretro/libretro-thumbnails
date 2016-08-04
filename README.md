# libretro-thumbnails

The RetroArch XMB menu can display thumbnails for any game in a playlist.

![Screenshot](http://www.lakka.tv/doc/images/thumbnails.png)

## Usage

1. The thumbnails are installed into the RetroArch config's `thumbnails` directory

2. There are three types of thumbnails:
    - `Named_Snaps` In game snapshots
    - `Named_Titles` Title screen snapshots
    - `Named_Boxarts` Boxart

3. Images must be PNG

4. They need to follow this naming convention:
    ```
    thumbnails/Playlist_Name/Named_Type/Game_Name.png
    ```

5. Any `/` in the game name are replaced with `-` for thumbnail filenames

## Scrapper

    ./tgdb.pl retroarch/media/libretrodb/dat/Nintendo\ -\ Super\ Nintendo\ Entertainment\ System.dat  
    mogrify -format png -resize 256x Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.jpg
    rm Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.jpg
