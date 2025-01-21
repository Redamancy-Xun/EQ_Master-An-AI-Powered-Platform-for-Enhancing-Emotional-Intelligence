import pandas as pd
import json

# 读取xlsx文件
def read_xlsx(file_path):
    # 跳过第一行
    df = pd.read_excel(file_path, skiprows=0)
    return df

# 生成JSON数据
def generate_json(df, row_index):
    json_data = {
        "messages": [
            {
                "role": "system",
                "content": "你是一个具有高情商的社交达人，现在有人来求助你一些情商难题，请你高情商回复。"
            },
                {
                    "role": "user",
                    "content": "我是一位遇到情商难题的人，我的情商难题是：{" + str(df.iloc[row_index, 0]) + "}。你是一个具有高情商的社交达人，请你高情商回复我的情商难题。"
                },
            {
                "role": "assistant",
                "content": "你可以这么回复：" + str(df.iloc[row_index, 1])
            }
        ]
    }
    return json_data

# 保存JSONL文件
def save_jsonl(json_data, output_file):
    with open(output_file, 'a', encoding='utf-8') as f:
        f.write(json.dumps(json_data, ensure_ascii=False) + '\n')

# 主函数
def main(input_file, output_file):
    df = read_xlsx(input_file)
    with open(output_file, 'w', encoding='utf-8') as f:
        pass  # JSONL 文件不需要初始化
    for index, row in df.iterrows():
        json_data = generate_json(df, index)
        save_jsonl(json_data, output_file)

if __name__ == "__main__":
    input_file = ".\\AI训练数据.xlsx"  # 替换为你的输入文件路径
    output_file = ".\\训练文本v1.0.jsonl"  # 替换为你的输出文件路径
    main(input_file, output_file)