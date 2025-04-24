/*------------------------------------------------------------------------
    File        : ${relativeFile#find=^.*src\/#replace=#}
    Purpose     : ${cursor}
    Author(s)   : ${author}
    Created     : ${dateTimeFormat}    
  ----------------------------------------------------------------------*/

enum ${relativeFile#find=^.*src\/#replace=##find=/#flags=g#replace=.##find=\.cls$#replace=#} flags :

    define enum
        ${input:values}
/*
        Value1 = 10
        Value2 = 20
        Value1and2 = Value1,Value2
*/

        .

end enum.