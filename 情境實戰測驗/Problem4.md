# Problem 4

## Solution

串接的部份會先考量到現行狀況來做評估：

- 如假設團隊現行已存在一個穩定的機制，會優先參考並選擇採用，例如已經統一 spec 且有特定 library(或者機制) 來處理 log stream，在沒有其他問題或者需要優化的前提下，以管理上的考量會直接引入並且採用。
- 如果沒有的話，看服務類型來進行設計，但會偏向選擇透過系統來進行傳送，而非讓程式直接送，考量到下面原因：
  - 減少程式耦合性
  - 減少性能損耗
  - 不需另外處理緩衝機制
  - 維運便利優勢
  - 擴展性及未來調整解決方案的彈性增加
- 透過系統處理也會有一些缺點需要注意並且另外處理
  - 會期望各產品可以標準化 log format
  - 根據平台不同會有不同配置：
    - Bare Metal instance
      - 會需要配置 agent
      - 需要關注 disk free space 監控
      - 整體的資源使用以及 disk I/O 會需要觀察並調整搭配
      - 確保 agent 運行的機制
      - 檔案權限以及機敏內容處理機制
      - log rotation
    - Kubernetes
      - 注意 Label 與 Namespace 來區分
      - RBAC 權限配置
      - 可能會需要另外配置 Persistent Volume
      - 部署方式選擇考量：
        - DaemonSet
          - 主要收集系統日誌或標準容器日誌
          - 方便統一管理和監控所有日誌收集器的狀態
        - Sidecar
          - 無法直接通過 stdout 收集，較好處理 log rotate
          - 需高度製化處理的 log

以 SRE 角度會比較偏向維運層面的部分：

- 維護成本考量
  - Elasticsearch index policy
    - lifecycle
    - Shard 跟 replica 配置
  - 配置標準化/自動化
  - 好除錯
- 日誌處理的特殊需求
- 資源配置
