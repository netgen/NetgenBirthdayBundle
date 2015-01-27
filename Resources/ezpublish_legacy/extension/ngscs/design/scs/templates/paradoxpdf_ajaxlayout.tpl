<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
{*<link rel="stylesheet" type="text/css" href={"stylesheets/print-core.css"|ezdesign} media="print,screen"></link>*}
<style type="text/css">
{literal}
/* Control page rendring: please refer to doc/doc.txt */
@page {
    size: a4 portrait;
    margin: 0.25in;
    padding: 1em;
    @top-left {
       content: element(header);
    }
     @bottom-right {
        content: element(footer);
      }
}

@font-face
{
font-family: "GHEA Grapalat";
src: url("{/literal}{'extension/ez_sense_rgm/design/eregistry/fonts/GHEAGrpalatReg.ttf'|ezroot(no,full)}{literal}");
-fs-pdf-font-embed: embed;
-fs-pdf-font-encoding: Identity-H;
}

body{
/*font-family: "GHEA Grapalat","Tahoma", monospace;*/
font-family: "GHEA Grapalat";
}
/*header as footer will automatically icluded in each pdf printed page*/
#header {
       display: block;
       padding : 3px;
       position: running(header);
       background : purple;
       color : #FFFFFF;
   }
 #footer {
      display: block;
      border-top: 1px solid black;
      position: running(footer);

    }



#pagenumber:before {
    content: counter(page);
}

#pagecount:before {
    content: counter(pages);
}

/* Used for generating Table of content */
#toc a::after { content: leader('.') target-counter(attr(href), page); }
/* Use this class for first level titles */
.page_break_before{ page-break-before: always; }

/* Use this class for forcing page break inside pdf */
.page_breaker{page-break-after:always;}



/* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
  {margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.MsoFootnoteText, li.MsoFootnoteText, div.MsoFootnoteText
  {margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.MsoCommentText, li.MsoCommentText, div.MsoCommentText
  {mso-style-link:"Comment Text Char";
  margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
  {margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
  {margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
span.MsoFootnoteReference
  {vertical-align:super;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
  {mso-style-link:"Plain Text Char";
  margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.MsoCommentSubject, li.MsoCommentSubject, div.MsoCommentSubject
  {mso-style-link:"Comment Subject Char";
  margin:0cm;
  margin-bottom:.0001pt;
  font-size:10.0pt;
  font-weight:bold;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
  {margin:0cm;
  margin-bottom:.0001pt;
  font-size:8.0pt;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
  {margin-top:0cm;
  margin-right:0cm;
  margin-bottom:0cm;
  margin-left:35.4pt;
  margin-bottom:.0001pt;
  font-size:10.0pt;}
p.Char, li.Char, div.Char
  {mso-style-name:Char;
  margin-top:0cm;
  margin-right:0cm;
  margin-bottom:8.0pt;
  margin-left:0cm;
  line-height:12.0pt;
  font-size:10.0pt;}
span.PlainTextChar
  {mso-style-name:"Plain Text Char";
  mso-style-link:"Plain Text";}
span.st
  {mso-style-name:st;}
span.CommentTextChar
  {mso-style-name:"Comment Text Char";
  mso-style-link:"Comment Text";}
span.CommentSubjectChar
  {mso-style-name:"Comment Subject Char";
  mso-style-link:"Comment Subject";
  font-weight:bold;}
.MsoChpDefault
  {font-size:10.0pt;}

 /* List Definitions */
 ol
  {margin-bottom:0cm;}
ul
  {margin-bottom:0cm;}

  textarea,
  input,
  select { font-size:inherit; font-family: inherit; }


#ftn1 p { font-size: 10pt; }
p.red { color: #C00000; }

span.checked,
span.not-checked { background: url({/literal}{'extension/ez_sense_rgm_armenia/design/eregistry_armenia/images/CheckBox.png'|ezroot(no,full)}{literal}) no-repeat;display: block; width: 19px; height: 22px; position: relative; clear: both; float: left; margin-right: 5px; overflow: hidden; }

span.checked { background-position: -1px -2px; top: -18px; }
span.not-checked { background-position: -22px -5px; top: -14px; }

textarea {display: none;}
{/literal}
</style>

{* Uncomment the folowing code to test and enable pdf bookmarks*}
{*include uri="design:includes/paradoxpdf_bookmarks.tpl"*}
<title></title>
</head>
<body>

{* <div id="header" style="font-family: Arial">headline - ✓, ✔, ☑, ☐</div> *}

{* The footer will be automatically placed at the end of each page*}
<div id="footer"><span id="pagenumber"/> / <span id="pagecount"/> </div>

{* Uncomment the folowing code to test and enable TOC Table of content*}
{*include uri="design:includes/paradoxpdf_toc.tpl"*}
{$body}
</body>
</html>
