# Local .terraform directories
**/.terraform/* - Игнорировать все файлы в каталоге .terraform

# .tfstate files
*.tfstate - Исключить все файлы с расширением .tfstate
*.tfstate.* - Игнорировать все файлы с tfstate

# Crash log files
crash.log - Игнорировать crash.log

# Exclude all .tfvars files, which are likely to contain sentitive data, such as
# password, private keys, and other secrets. These should not be part of version
# control as they are data points which are potentially sensitive and subject
# to change depending on the environment.
#
*.tfvars - Исключить все файлы с расширением tfvars

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf - Игнорировать override.tf
override.tf.json - Игнорировать override.tf.json
*_override.tf -  Игнорировать файлы где встречается название *_override.tf 
*_override.tf.json - Игнорировать файлы где встречается название *_override.tf.json

# Include override files you do wish to add to version control using negated pattern
#
# !example_override.tf - отслеживать !example_override.tf даже если он попадает в исключение выше

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc - Игнорировать файл с расширением .terraformrc
terraform.rc - Игнорировать файл terraform.rc