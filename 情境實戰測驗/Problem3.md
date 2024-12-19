# Problem 3

## Solution

這邊假設情境:

- 理解題目描述並非網路異常，也非防火牆，指的可能是 server side 的狀況，但 client <-> server 這段可能還未釐清？
- 使用 client host 的 SSH client(terminal) 進行 ssh 連線。

在 `由於不明原因導致無法再次透過 SSH 登入` 的前提可能代表預期中之前是可以登錄的，然後現在不行，這種情況進行排查:

1. 如果有相同 Security Group 的 ec2 instance 會先快速測試一下是否可以如預期登入

   - 如果可以，判斷可能只是該 instance 有異常，進行步驟 2 檢查

   - 如果也不能登入，會先檢查 IAM 賬號狀態，e.g. Access keys Status/Permissions...etc
   - 到這邊先排除 AWS 賬號問題。

2. 確認 `無法再次透過 SSH 登入` 這個行為的 error code 來先釐清是 Clien / Server 的問題。

3. 例如(包含但不僅限於):

   - Permission denied (publickey)

   - Could not open a connection to your authentication agent

   - Connection refused
   - Connection reset by peer

   - ...etc

4. Client 問題:

   - 帳號打錯(e.g. admin@ / ec2-user@ ...etc)

   - 根據 error code 來進行調整修復，例如 openssh 相關設定檔/權限/agent 狀態/ssh client 版本過舊...等

   - 網路問題，自己想辦法弄到通(e.g. VPN routing/application security rule...etc)

5. Server 問題:

   - instance resource over-utilization
     - 找到系統 overloaded 原因並排除

   - 檢查該 EC2 Security Group
     - 確認是否有被調整過但沒被同步通知到(算嚴重，事後需確實調查原因)，並修正

   - Key Pair 狀態
     - 確認是否過期，或者該 key 所使用加密算法已被 deprecated (support discontinued)

   - 硬碟已經 100%
     - 導致 session info 無法寫入造成登入異常

   - 確認 instance IP 如預期
     - 該 instance 的 eip 被換過，或者其他非預期狀況導致無法連線

   - ...etc

在解決這個問題的思路上需先釐清是突然無法登入還是原本可以，但是已經過了一段時間要用卻無法登入，這樣可以先排除像是是 AWS 賬號問題(credential)，再快速釐清是本機問題還是該 EC2 問題，接著根據 error message 以及遇到的狀況來判斷並進行排除。
