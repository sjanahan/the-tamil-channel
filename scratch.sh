vcodec="mp4v"
acodec="mp4a"
vb="1024"
ab="128"
mux="mp4"
    
vlc -I dummy -vvv "WhatsApp Ptt 2020-11-20 at 08.38.40.ogg" --sout='#transcode{acodec=mp3,ab=128}:standard{mux=mp3,dst=test.mp3,access=file}' vlc://quit