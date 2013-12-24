# BuildHeader
# Build Header for REST API call
# This is redundant, we should be using OAUTH

BuildHeader <- function() {
  print("BuildHeader.R - THIS AUTH METHOD IS REDUNDANT, SHOULD BE USING OAUTH")
  #Create nonce
  nonce <- as.character(as.numeric(Sys.time()))
  #Create timestamp
  created.date <- format(Sys.time()-11*60*60, "%Y-%m-%dT%H:%M:%SZ")
  #Concatentate nonce, timestamp, shared secret, then sha1 then base64
  nonce.create.secret <- paste(nonce, created.date, AA.Credentials[2], sep="")
  sha.object <- digest(nonce.create.secret, algo="sha1", serialize=FALSE)
  password.digest <- base64encode(charToRaw(sha.object))

  #Build & Return Header 
  return(paste('X-WSSE: UsernameToken Username=\"',AA.Credentials[1], '\"', ',', ' PasswordDigest=\"',password.digest, '\"', ',', ' Nonce=\"', nonce, '\"', ',', ' Created=\"', created.date, '\"', sep=""))
  
}