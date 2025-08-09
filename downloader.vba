Sub AutoExec()
  Dim result
  result = Shell("powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand 'VwByAGkAdABlAC0ASABvAHMAdAAgAGgAaQAhAA=='", 0)

  If result = 0 Then
    Exit Sub
  End If
End Sub
