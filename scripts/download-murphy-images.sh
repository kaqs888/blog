#!/bin/bash
# Murphy 教程图片下载脚本

IMG_DIR="/Users/dongbin/blog/static/images/murphy"
PROXY="socks5://127.0.0.1:6152"

mkdir -p "$IMG_DIR"

# 图片列表 (链接 -> 本地文件名)
declare -A IMAGES=(
    ["https://pbs.twimg.com/media/GqrPH8sXIAAikut?format=jpg&name=medium"]="mvrv-backdivergence.jpg"
    ["https://pbs.twimg.com/media/G49lnC6bIAAp94s?format=jpg&name=large"]="mvrv-fair-value.jpg"
    ["https://pbs.twimg.com/media/GsumQ1da4AA0ovT?format=jpg&name=medium"]="mvrv-deviation-bands.jpg"
    ["https://pbs.twimg.com/media/GrC_W_SaAAQ7Cab?format=jpg&name=medium"]="aviv-divergence.jpg"
    ["https://pbs.twimg.com/media/GURG-YwbcAAWiEr?format=jpg&name=large"]="sth-mvrv.jpg"
    ["https://pbs.twimg.com/media/G4wXKXea8AAnIcQ?format=jpg&name=large"]="urpd-huge-volume.jpg"
    ["https://pbs.twimg.com/media/GzbU30dacAAmshF?format=jpg&name=large"]="urpd-gap.jpg"
    ["https://pbs.twimg.com/media/GxaTp-7bIAECPMb?format=jpg&name=medium"]="dual-anchor.jpg"
    ["https://pbs.twimg.com/media/G4pKac-bQAEcggJ?format=jpg&name=medium"]="chip-concentration.jpg"
    ["https://pbs.twimg.com/media/HA2NHgOaQAAtcIk?format=jpg&name=large"]="realized-price.jpg"
    ["https://pbs.twimg.com/media/Gpy1LRwaYAAZbUt?format=jpg&name=large"]="age-based-cost.jpg"
    ["https://pbs.twimg.com/media/G5dzL24bMAABlNf?format=jpg&name=medium"]="investor-confidence.jpg"
    ["https://pbs.twimg.com/media/G65XVHTbkAE7iof?format=jpg&name=large"]="spi-inversion.jpg"
    ["https://pbs.twimg.com/media/G7tZ6OkboAAnssH?format=jpg&name=900x900"]="exchange-balance.jpg"
    ["https://pbs.twimg.com/media/Gqr2_VPXIAAMbup?format=jpg&name=medium"]="capital-flow.jpg"
    ["https://pbs.twimg.com/media/GhYdhTvbgAAMHBX?format=jpg&name=medium"]="usdc-usdt-rate.jpg"
    ["https://pbs.twimg.com/media/GdcYR2FaIAAXRre?format=jpg&name=medium"]="three-lines.jpg"
    ["https://pbs.twimg.com/media/GDy_aN-bQAAXiJy?format=jpg&name=900x900"]="yearly-kline.jpg"
    ["https://pbs.twimg.com/media/GXgdTeGa4AAuG18?format=jpg&name=medium"]="realized-profit.jpg"
    ["https://pbs.twimg.com/media/G6WYkYDakAEvn1W?format=jpg&name=medium"]="earl-ath.jpg"
    ["https://pbs.twimg.com/media/G2gPq_9aUAA6lUY?format=jpg&name=medium"]="upul-divergence.jpg"
    ["https://pbs.twimg.com/media/G7vIahXaEAAu-C0?format=jpg&name=medium"]="psip-line.jpg"
    ["https://pbs.twimg.com/media/GJhgolTboAAwQgQ?format=jpg&name=medium"]="whale-layers.jpg"
    ["https://pbs.twimg.com/media/HCd1Be1acAAej4y?format=jpg&name=large"]="super-whale.jpg"
    ["https://pbs.twimg.com/media/G_ABibsXAAAmRfJ?format=jpg&name=large"]="gex-analysis.jpg"
    ["https://pbs.twimg.com/media/GnbHK5ibAAA1x0w?format=png&name=large"]="launchpool-data.jpg"
    ["https://pbs.twimg.com/media/HCilswJa0AAuhBM?format=jpg&name=medium"]="brs-signal.jpg"
    ["https://pbs.twimg.com/media/GpOmbQ0aIAEUuNG?format=jpg&name=large"]="rsi-behavior.jpg"
)

echo "开始下载 ${#IMAGES[@]} 张图片..."

for url in "${!IMAGES[@]}"; do
    filename="${IMAGES[$url]}"
    output="$IMG_DIR/$filename"
    
    if [ -f "$output" ]; then
        echo "✓ 已存在：$filename"
        continue
    fi
    
    echo "下载：$filename"
    curl -x "$PROXY" -s -L -o "$output" "$url"
    
    if [ $? -eq 0 ] && [ -s "$output" ]; then
        echo "  ✓ 成功"
    else
        echo "  ✗ 失败"
        rm -f "$output"
    fi
    
    sleep 1
done

echo ""
echo "下载完成！"
ls -la "$IMG_DIR"
