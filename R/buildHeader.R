# buildHeader
# Build Header for REST API call
# This is redundant, we should be using OAUTH

buildHeader <- function() {
  print("buildHeader.R - THIS AUTH METHOD IS REDUNDANT, SHOULD BE USING OAUTH")
  #Create nonce
  nonce <- as.character(as.numeric(Sys.time()))
  #Create timestamp
  created_date <- format(Sys.time()-11*60*60, "%Y-%m-%dT%H:%M:%SZ")
  #Concatentate nonce, timestamp, shared secret, then sha1 then base64
  nonce_create_secret <- paste(nonce, created_date, AACredentials[2], sep="")
  sha_object <- digest(nonce_create_secret, algo="sha1", serialize=FALSE)
  password_digest <- base64encode(charToRaw(sha_object))

  #Build & Return Header 
  return(paste('X-WSSE: UsernameToken Username=\"',AACredentials[1], '\"', ',', ' PasswordDigest=\"',password_digest, '\"', ',', ' Nonce=\"', nonce, '\"', ',', ' Created=\"', created_date, '\"', sep=""))
  
}