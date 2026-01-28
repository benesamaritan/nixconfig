{ config, ... }:

{
  age.secrets.hashedPassword.file = ./secrets/hashedPassword.age;
  age.identityPaths = [ "/home/bye/.ssh/id_rsa" ];
}