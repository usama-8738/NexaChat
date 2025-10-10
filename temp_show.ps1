Get-Content -Path 'lib/src/features/payments/presentation/views/add_card_screen.dart' -Raw | % { [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::UTF8.GetBytes()) }
