# libretro-thumbnails

The RetroArch XMB menu can display thumbnails for any game in a playlist.

![Screenshot](http://www.lakka.tv/doc/images/thumbnails.png)

## Using and adding to the libretro thumbnail repository

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

5. The following characters in playlist titles must be replaced with `_` in the corresponding thumbnail filename:
    ```
    &*/:`<>?\|
    ```
6. Thumbnail images submitted to this repository should not be greater than 512px wide. Images with native widths greater than this should be scaled down to 512px wide before submission.

## Scraper

    ./tgdb.pl retroarch/media/libretrodb/dat/Nintendo\ -\ Super\ Nintendo\ Entertainment\ System.dat  
    mogrify -format png -resize 512x Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.png
    rm Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.png
