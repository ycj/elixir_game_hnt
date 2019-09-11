defmodule HG do
  # 程序入口
  def main do
    HNT.start(8)
  end
end

# 汉诺塔原理推导程序
defmodule HNT do

  def start(x) do
    data = init(x)
    process data
  end

  # 递归步骤
  def process(data) do
    size = map_size(data)
    level = div(size, 3)
    IO.puts "hnt floor: #{level}"
    display data
    step(data, level, 0, 2)
  end

  # 基本移动
  def move(data, from , to) do
    data = Map.put(data, from, 0)
    data = Map.put(data, to  , 1)
    display data
    data
  end

  # 移动规则
  def step(data, 1, source_column, target_column) do
    move(data, [0, source_column], [0, target_column])
  end

  def step(data, level, source_column, target_column) do
    # 计算临时存放列
    temp_column = case source_column + target_column do
      2->1
      1->2
      3->0
    end
    data = step(data, level-1, source_column, temp_column)
    data = move(data, [level-1, source_column], [level-1, target_column]) # row index = level - 1
    data = step(data, level-1, temp_column, target_column)
  end

  #  MAP打印，调试目的
  def display(data) do
    Enum.map(data, fn {k,v} ->
      [_, column] = k
      sep = case column do
        2-> "\n"
        _ -> "   "
      end
      IO.write "#{v}#{sep}"
    end)
    IO.puts "---------"
  end

  #  初始化基本数据结构
  def init(level) do
    data = %{}
    Enum.reduce(1..level*3, data, fn x, acc ->
      x = x - 1
      column = rem x, 3
      row = div x, 3
      value = if column == 0 do
        1
      else
        0
      end
      acc = Map.put(acc, [row, column], value)
    end)
  end
end