# Solution

```sql
# 從 score 表格中選取學生的名字以及從 class 表格中選取學生所在的班級，並匹配 name 欄位，將兩張表 join 起來
# 使用 score 來降冪排列，然後取出第 2 順位的單筆紀錄

SELECT s.name, c.class FROM score s JOIN class c ON s.name = c.name ORDER BY s.score DESC LIMIT 1 OFFSET 1;
```
