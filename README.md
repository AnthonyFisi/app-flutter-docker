# App-flutter-docker

## Example

### Step 1

Clone this porject 

```
git clone https://github.com/AnthonyFisi/app-flutter-docker.git

```

### Step 2

Search your computer's ip address 

- Windows : ```ipconfig```
- MacOs or Linux : ```ifconfig -a ```

### Step 3

Go to path : ...\workspace\flutter_postgrest\lib\login\UserRepository

Enter to UserRepository and replace default ip address by your ip address.

```
String url = 'http://<ip address>:3000/rpc/login';

```
### Step 4

Before to start we need to connect your phone for compile our apk.
- Connect your phone with the computer
- Turn on your phone and go to setting -> wifi -> your red wifi -> advanced options
- Copy ip address in any edit text

### Step 5

Now open docker-compose.yml and go to line 38 and modified this line with ip address that you save in your edit text.

```
adb connect <IP ADDRESS PHONE>:5556
```

### Step 6

Now open a terminal in your computer and write the following commands
- ``` adb devices ```
- ``` adb tcpip 5556 ```
- ``` adb connect <IP ADDRESS PHONE>:5556 ```
- ``` adb devices ```

### Step 7 
<p>After complete all steps is hour to running this compose <br>
Open a terminal <br>
Go to path and runnig the following command </p>
 
 ``` 
 docker-compose up -d
 ```

### References
If need specific details go to here
 > https://blog.codemagic.io/how-to-dockerize-flutter-apps/


