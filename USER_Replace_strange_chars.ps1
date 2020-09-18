function replace($str)

{

$str = $str -replace("ü", "ue")

$str = $str -replace("ö", "oe")

$str = $str -replace("ä", "ae")

$str = $str -replace("ö", "oe")

$str = $str -replace("ü", "ue")

$str = $str -replace("Ä", "Ae")

$str = $str -replace("Ö", "Oe")

$str = $str -replace("Ü", "Ue")

$str = $str -replace("ß", "ss")

$str = $str -replace("â", "a")

$str = $str -replace("è", "e")

$str = $str -replace("é", "e")

$str = $str -replace("'", "")

$str = $str -replace("  ", " ") 

return $str

}

function onPreCreate($Request)

{

$cn = $request.get("cn")

$cn = replace($cn)

$request.put("cn", $cn)

$sam = $request.get("sAMAccountName")

$sam = replace($sam)

$request.put("sAMAccountName", $sam)

$upn = $request.get("userPrincipalName")

$upn = replace($upn)

$request.put("userPrincipalName", $upn)

}