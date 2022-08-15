output "service_accounts_map" {
  #value = {for k, v in google_service_account.service_account: k.name => v.email}
  #value = {for sa in google_service_account.service_account: sa.name => sa.email}
  value = tomap({
    for k, v in google_service_account.service_account : k => v.email
  })

  depends_on = [
    google_service_account.service_account
  ]
}

output "service_account_private_keys" {
  #value = {for k, v in google_service_account_key.json_key_generator: k.name => v.email}
  #value = {for prv in google_service_account_key.json_key_generator: prv.name => prv.private_key}
  value = tomap({
    for k, v in google_service_account_key.json_key_generator : k => v.private_key
  })

  depends_on = [
    google_service_account_key.json_key_generator
  ]
}
