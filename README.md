# libretro-thumbnails

The RetroArch XMB menu can display thumbnails for any game in a playlist.

![Screenshot](http://www.lakka.tv/doc/images/thumbnails.png)

## Thumbnail repository layout

1. The thumbnails are installed into the RetroArch config's `thumbnails` directory

2. There are three types of thumbnails:
    - `Named_Snaps` In game snapshots
    - `Named_Titles` Title screen snapshots
    - `Named_Boxarts` Boxart

3. Thumbnail files need to follow this naming convention:
    ```
    thumbnails/Playlist_Name/Named_Type/Game_Name.png
    ```

4. The following characters in playlist titles must be replaced with `_` in the corresponding thumbnail filename:
    ```
    &*/:`<>?\|
    ```

## Thumbnail submission guidelines

1. Images must be PNG
2. Images submitted to this repository should not be greater than 512px wide. Images with native widths greater than this should be scaled down to 512px wide before submission.
3. When official boxart is not available for a system, as for example with arcade ROMs, it is acceptable to substitute promotional flyers. Boxart for unlicensced and prototype titles is welcome, but in no case should fan-made or mockup boxart be submitted.
4. Use [RobLoach/libretro-thumbnails-check](https://github.com/RobLoach/libretro-thumbnails-check) to check for missing thumbnails and/or orphaned files.

## Thumbnail scraper tool

These example commands can be modified to scrape thumbnail images for other systems or in other source formats. 

    ./tgdb.pl retroarch/media/libretrodb/dat/Nintendo\ -\ Super\ Nintendo\ Entertainment\ System.dat  
    mogrify -format png -resize 512x Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.jpg
    rm Nintendo\ -\ Super\ Nintendo\ Entertainment\ System/Named_Boxarts/*.jpg

### Explanation:

1. Retrieve the RetroArch database records for the Nintendo - Super Nintento Entertainment System
2. Use the ImageMagick mogrify tool to convert a batch of jpg thumbnails to png format at the correct maximum width
3. Remove the source jpg files (this third line can be removed if scraping files already in PNG format)
