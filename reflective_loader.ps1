$payload = "<SOME_BASE64_ENCODED_ASSEMBLY>"
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
