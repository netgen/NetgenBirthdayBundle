<?php /* #?ini charset="iso-8859-1"?
# eZ publish extended attribute filter configuration file.

[ReverseRelationsFilter]
#The name of the extension where the filtering code is defined.
ExtensionName=ngscs
#The name of the filter class.
ClassName=eZReverseRelationsFilter
#The name of the method which is called to generate the SQL parts.
MethodName=createSqlParts
#The file which should be included (extension/myextension will automatically be prepended).
FileName=classes/ezreverserelationsfilter.php

[NodeHasChildrenFilter]
#The name of the extension where the filtering code is defined.
ExtensionName=ngscs
#The name of the filter class.
ClassName=NodeHasChildrenFilter
#The name of the method which is called to generate the SQL parts.
MethodName=createSqlParts
#The file which should be included (extension/myextension will automatically be prepended).
FileName=classes/eznodehaschildrenfilter.php

[NodeChildrenCountFilter]
#The name of the extension where the filtering code is defined.
ExtensionName=ngscs
#The name of the filter class.
ClassName=NodeChildrenCountFilter
#The name of the method which is called to generate the SQL parts.
MethodName=createSqlParts
#The file which should be included (extension/myextension will automatically be prepended).
FileName=classes/eznodechildrencountfilter.php


*/ ?>
