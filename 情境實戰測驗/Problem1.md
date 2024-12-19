# Problem 1

## Solution

為了確保服務能在推廣期間正常運作，規劃上會以 `架構調整` / `效能評估` / `監控告警` 三個部分做重點評估規劃，並將這個題目的重點放在穩定提供線上服務，關於開發上版這類相依性的工作流以及其環境調整則先不予考量。

另外網站要正常運作除了 web 本身外，會相依到 cache, database 以及其他服務，但這邊主要先以 general-purpose infrastructure 來做討論。

- 架構調整
  - Scalable
    - 確保 autoscaling 機制，並針對活動優化 scaling policy 設計，如在雲上另外需要注意服務的各種 default limit
    - Across multiple regions/AZ 的情境可能會需要針對不同區域做資源配置
    - Instance type right-sizing，特別是網卡性能，確保夠用且不會 Overprovisioning，特別是在 cloud
    - failover / failback相關配置調整，盡可能影響對用戶的使用體驗
    - 預留一定比例資源給預期外的用量，針對使用情境，可能例如 storage / cluster node ...etc
    - Emergency Scaling and Response Plan
      - 準備假如發生大於預期流量的快速擴容計劃，可能會包含 資源準備 / 手動擴容腳本 / cloud provider 預先請 support 開大 limit 等工作
    - 如果活動 peak 是有先例或者可預期的，可以設計自動預擴容用來增加穩定且大幅減少浪費開支
  - Cache
    - 可能會包含調整快取相關機制的設定，針對該活動專案優化 cache rule
    - 如是跨境活動可能需要 review 關於 CDN 的相關配置
  - Security
    - 相依服務中如有 End-to-end encryption 則需注意憑證相關配置
    - 相關防禦機制檢查，包含 WAF(rule) / SSL(TLS)
    - Traffic Management，LB policy /
    - 確認 block list(rule) 沒有阻擋到預期外的對象
- 效能評估
  - 在完成系統架構調整之後，對其進行 Stress Testing / Benchmarking 用來評估性能，並驗證調整後架構的系統環境
  - 確認結果可接受，如否亦會在這個階段進行優化，確保更少的資源能夠提供更大的流量
  - 同時也在這個階段評估所需要的資源，需要預留多少，cost 資訊評估，確保善用硬體資源並穩定支撐該活動網站服務。
- 監控告警
  - 為此活動特別設定一些更靈敏的監控，並且能夠告警相關人員，使工程能夠比用戶更早察覺問題來維持用戶體驗
  - 這些告警包含但不僅限於 latency / loading / network traffic / I/O...tec
  - 如需要也可以多記錄一些活動當下的服務端數據用來作為未來參考，通常都是有足夠的流量後各種問題才會浮現。

針對不同 tech stack / 情境 / 需求 或許可以有更多或者不一樣的考量，上面提供一些經驗以及思路供參。
