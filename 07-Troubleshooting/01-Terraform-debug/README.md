## Sample exercise
Set:
```
export TF_LOG_PROVIDER=DEBUG
export TF_LOG=""
export TF_LOG_PATH=~/temp/terraform.log

```
Execute terraform plan, refresh,  apply or destroy 

In a separate window observe behavior

```
tail -f ~/temp/terraform.log | grep -e '^DELETE\|^GET\|^PUT /subscriptions/' -e 'HTTP/2.0 201 Created' 

```

(modify grep regex if you are only interested, say, in PUT (apply) or GET (destroy))


## Useful Terraform Debugging Commands

You can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.

```
export TF_LOG=TRACE
export TF_LOG=DEBUG
export TF_LOG=INFO
export TF_LOG=WARN
export TF_LOG=ERROR
export TF_LOG=

export TF_LOG_PROVIDER=TRACE
export TF_LOG_PROVIDER=DEBUG
export TF_LOG_PROVIDER=INFO
export TF_LOG_PROVIDER=WARN
export TF_LOG_PROVIDER=ERROR
export TF_LOG_PROVIDER=


export TF_LOG_CORE=TRACE
export TF_LOG_CORE=DEBUG
export TF_LOG_CORE=INFO
export TF_LOG_CORE=WARN
export TF_LOG_CORE=ERROR
export TF_LOG_CORE=

# Note TF_LOG_PATH should include also the file name
export TF_LOG_PATH=/var/log/terraform.log
```


## Useful combination to see AWS API Calls

```
export TF_LOG_PROVIDER=DEBUG
export TF_LOG_PATH=/tmp/terraform.log
# Most AWS API calls start with "Action="  
tail -f /tmp/terraform.log | grep "Action="

```
