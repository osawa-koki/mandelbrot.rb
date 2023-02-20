require 'chunky_png'

# 画像のサイズ
WIDTH, HEIGHT = 800, 800

# 描画する範囲
X_MIN, X_MAX = -2.0, 1.0
Y_MIN, Y_MAX = -1.5, 1.5

# 最大反復回数
MAX_ITERATIONS = 100

# 画像の初期化
png = ChunkyPNG::Image.new(WIDTH, HEIGHT, ChunkyPNG::Color::BLACK)

# マンデルブロ集合の計算
(0...WIDTH).each do |x|
  (0...HEIGHT).each do |y|
    # 座標の変換
    zx = X_MIN + (X_MAX - X_MIN) * x / (WIDTH - 1.0)
    zy = Y_MIN + (Y_MAX - Y_MIN) * y / (HEIGHT - 1.0)

    # マンデルブロ集合の計算
    z = 0.0
    iteration = 0
    while z.abs < 2 && iteration < MAX_ITERATIONS
      z = z * z + Complex(zx, zy)
      iteration += 1
    end

    # ピクセルの色を設定
    if iteration == MAX_ITERATIONS
      color = ChunkyPNG::Color::WHITE
    else
      color = ChunkyPNG::Color.rgb(iteration * 5, iteration * 5, 255 - iteration * 5)
    end

    # 画像に描画
    png[x, y] = color
  end
end

# 画像を保存
png.save('mandelbrot.png', :interlace => true)
