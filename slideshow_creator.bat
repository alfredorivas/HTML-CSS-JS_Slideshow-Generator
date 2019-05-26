REM ==================================================================================================================
REM -- https://www.w3schools.com/howto/tryit.asp?filename=tryhow_js_slideshow_gallery
REM -- https://stackoverflow.com/questions/16445379/batch-file-fore-creating-base-html-files-folders
REM -- https://stackoverflow.com/questions/45809295/batch-file-read-file-names-from-a-directory-and-store-in-array
REM -- https://stackoverflow.com/questions/4419868/what-is-the-current-directory-in-a-batch-file
REM -- http://www.informit.com/articles/article.aspx?p=1154761&seqNum=10
REM ==================================================================================================================

@echo off

REM almaceno el nombre de la salida
REM las imágenes hay que ponerlas en una carpeta "img"
set output=index.html

REM guardo en un array los filenames (ACEPTA PNG/JPG/JPEG/BMP/GIF)
SetLocal EnableDelayedexpansion
@FOR %%f IN (img\*.png img\*.jpg img\*.jpeg img\*.bmp img\*.gif) DO (
	set /a "idx+=1"
	set "filename[!idx!]=%%~nxf"
)

REM armo el HTML+CSS+JS (primera parte)
(
echo(^<!DOCTYPE html^>
echo(^<html^>
echo(	^<head^>
echo(		^<meta name="viewport" content="width=device-width, initial-scale=1"^>
echo(		^<title^>^Slideshow Gallery^</title^>
echo(		^<style^>
echo(			body {
echo(				font-family: Arial;
echo(				margin: 0;
echo(			}
echo(			* {box-sizing: border-box}
echo(			.mySlides1 {display: none}
echo(			img {vertical-align: middle; max-height: 510px;}
echo(
echo(			/* Slideshow container */
echo(			.slideshow-container {
echo(				max-width: 900px;
echo(				position: relative;
echo(				margin: auto;
echo(			}
echo(
echo(			/* Next ^& previous buttons */
echo(			.prev, .next {
echo(				cursor: pointer;
echo(				position: absolute;
echo(				top: 50%%;
echo(				width: auto;
echo(				padding: 16px;
echo(				margin-top: -22px;
echo(				color: white;
echo(				font-weight: bold;
echo(				font-size: 18px;
echo(				transition: 0.6s ease;
echo(				border-radius: 0 3px 3px 0;
echo(				user-select: none;
echo(			}
echo(
echo(			/* Position the "next button" to the right */
echo(			.next {
echo(				right: 0;
echo(				border-radius: 3px 0 0 3px;
echo(			}
echo(
echo(			/* On hover, add a grey background color */
echo(			.prev:hover, .next:hover {
echo(				background-color: #f1f1f1;
echo(				color: black;
echo(			}
echo(
echo(			/* Container for caption text */
echo(			.caption-container {
echo(				text-align: center;
echo(				background-color: #222;
echo(				padding: 2px 16px;
echo(				color: white;
echo(				font-size: 12px;
echo(			}
echo(		^</style^>
echo(	^</head^>
echo(
echo(	^<body^>
echo(		^<h1 style="text-align:center"^>^<i^>Slideshow Gallery^</i^>^</h1^>
echo(
echo(		^<div class="slideshow-container"^>
)> "%output%"

REM imprimo los divs con los nombres de las imágenes
for /L %%i in (1,1,%idx%) do (
    (
		echo(			^<div class="mySlides1"^>
        echo(				^<img src="img\!filename[%%i]!" style="width:100%%"^>
		echo(			^</div^>
		echo(
    )>> "%output%"
)

REM armo el HTML+CSS+JS (segunda parte)
(
echo(			^<a class="prev" onclick="plusSlides(-1, 0)"^>^&^#10094;^</a^>
echo(			^<a class="next" onclick="plusSlides(1, 0)"^>^&^#10095;^</a^>
echo(
echo(			^<div class="caption-container"^>
echo(				^<p id="caption"^>^<b^>Samsung Electronics Argentina^</b^>^</p^>
echo(			^</div^>
echo(		^</div^>
echo(
echo(		^<script^>
echo(			var slideIndex = [1, 1];
echo(			var slideId = ["mySlides1", "mySlides2"]
echo(			showSlides(1, 0^)^;
echo(			showSlides(1, 1^)^;
echo(
echo(			function plusSlides(n, no^) ^{
echo(				showSlides(slideIndex^[no^] ^+^= n, no^)^;
echo(			^}
echo(
echo(			function showSlides(n, no^) ^{
echo(				var i;
echo(				var x = document.getElementsByClassName(slideId^[no^]^)^;
echo(				if (n ^> x.length^) ^{slideIndex[no^] = 1^}
echo(				if (n ^< 1^) ^{slideIndex[no^] = x.length^}
echo(				for (i = 0^; i ^< x.length; i^+^+^) ^{
echo(					x^[i^].style.display = "none";
echo(				^}
echo(				x^[slideIndex^[no^]^-1].style.display = "block";  
echo(			^}
echo(		^</script^>
echo(	^</body^>
echo(^</html^>
)>> "%output%"