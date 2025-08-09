$contents = [System.IO.File]::ReadAllBytes("<SOME_ASSEMBLY>")
$payload = [System.Convert]::ToBase64String($contents)
$bytes = [System.Convert]::FromBase64String($payload)
$asm = [System.Reflection.Assembly]::Load($bytes)
$entrypoint = $asm.EntryPoint
$params = @()
if ($entrypoint.GetParameters().Length -gt 0) {
  $params = ,@([string[]]@())
}

$instance = $null
if (-not $entrypoint.IsStatic) {
  $instance = $asm.CreateInstance($entrypoint.DeclaringType.FullName)
}

$entrypoint.Invoke($instance, $params)
