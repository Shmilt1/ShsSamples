$bytes = [System.IO.File]::ReadAllBytes("<SOME_ASSEMBLY>")
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
