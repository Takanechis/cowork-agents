# YouTube 動画の字幕をテキストで取得する手順

学習ソースとして YouTube 動画を渡されたとき、動画を再生せずに字幕から内容を読む手順。
2026年11月4日に Blender 講座の学習で使い、動作を確認した。

## 環境

- yt-dlp はこの Mac に入っていない。
- Python 3 は `/opt/homebrew/bin/python3` にある。
- `youtube-transcript-api` を `$TMPDIR` 配下の venv に入れて使う。ネットワークは pypi.org と files.pythonhosted.org の許可が要る。
- 字幕取得には www.youtube.com への接続許可が要る。

## 手順

1. venv を作って `youtube-transcript-api` を入れる。

```bash
cd "$TMPDIR" && python3 -m venv ytvenv && ./ytvenv/bin/pip install -q youtube-transcript-api
```

1. 動画 ID を引数に取るスクリプトを書き、`-I` 付きで実行する。日本語字幕を優先し、なければ英語にする。

```python
import sys
from youtube_transcript_api import YouTubeTranscriptApi
vid = sys.argv[1]
tl = YouTubeTranscriptApi().list(vid)
tr = None
for code in ["ja", "en"]:
    try:
        tr = tl.find_transcript([code]); break
    except Exception:
        pass
if tr is None:
    tr = next(iter(tl))
lines = [f"[{int(s.start)//60:02d}:{int(s.start)%60:02d}] {s.text}" for s in tr.fetch()]
open(f"{vid}.txt", "w").write("\n".join(lines))
```

1. タイトルと投稿者は oEmbed で取れる。API キーは不要。

```bash
curl -s "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=<動画ID>&format=json"
```

## 落とし穴

- `$TMPDIR` は `/tmp/claude-501` を指す。スクラッチパッドのパスとは別なので、Read するときは `$TMPDIR` の実体パスを使う。
- 日本語字幕は自動生成のことが多く、固有名詞や操作名の誤変換が多い。例、「I キー」が「背景」や「IQ」、「G キー」が「地域」や「磁気」、「Shift+Ctrl+V」が「シフトコントロールV」。文脈から読み替える。
- 1時間を超える動画は字幕が3000行前後になる。Read は 1000 行ずつに分けて読む。
- 字幕には音楽や無音の区間が「[音楽]」として入る。
