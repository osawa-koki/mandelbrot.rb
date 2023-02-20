require 'chunky_png'
require 'yaml'

# YAMLファイルを読み込む
config = YAML.load_file('config.yaml')['mandelbrot']

# マンデルブロ集合の設定を取得する
width = config['width']
height = config['height']
x_min = config['x_min']
x_max = config['x_max']
y_min = config['y_min']
y_max = config['y_max']
max_iterations = config['max_iterations']
output = config['output']

# 画像の初期化
png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::BLACK)

# マンデルブロ集合の計算
(0...width).each do |x|
  (0...height).each do |y|
    # 座標の変換
    zx = x_min + (x_max - x_min) * x / width
    zy = y_min + (y_max - y_min) * y / height

    # マンデルブロ集合の計算
    z = 0.0
    iteration = 0
    while z.abs < 2 && iteration < max_iterations
      z = z * z + Complex(zx, zy)
      iteration += 1
    end

    # ピクセルの色を設定
    if iteration == max_iterations
      color = ChunkyPNG::Color::WHITE
    else
      color = ChunkyPNG::Color.rgb(iteration * 5, iteration * 5, 255 - iteration * 5)
    end

    # 画像に描画
    png[x, y] = color
  end
end

# 画像を保存
png.save(output, :interlace => true)
