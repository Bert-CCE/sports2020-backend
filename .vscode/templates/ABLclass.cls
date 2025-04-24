/*------------------------------------------------------------------------
    File        : ${relativeFile#find=^.*src\/#replace=#}
    Purpose     : ${cursor}
    Author(s)   : ${author}
    Created     : ${dateTimeFormat}    
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

class ${relativeFile#find=^.*src\/#replace=##find=/#flags=g#replace=.##find=\.cls$#replace=#}:


end class.