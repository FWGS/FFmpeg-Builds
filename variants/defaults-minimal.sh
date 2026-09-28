#!/bin/bash
FF_CONFIGURE+=" --disable-avfilter --disable-avdevice --disable-autodetect --disable-iconv"

#
# There is no specification on what mods can ship and what they can't, but the evidence is that:
# - Mods that targeted Half-Life WON could have cinematics, therefore legacy and small memory footprint codecs are enabled
# - Mods that targeted HL25 would only use WebM which has a strict set of FOSS and royalty-free codecs
# - Mods that targeted OG Xash3D would use what VFW allowed, but I never seen them using any modern codecs
# - ... And in Xash3D FWGS we only formally support WebM, also pushing for FOSS codecs
#
FF_CONFIGURE+=" --disable-everything --disable-network --disable-hwaccels --enable-protocol=file"
FF_CONFIGURE+=" --enable-demuxer=avi,mov,matroska,ogg,mpegps,mpegvideo,m4v,h264,ivf,flv,bink,smacker,roq,wav,mp3,aac,flac"
FF_CONFIGURE+=" --enable-decoder=h264,vp8,vp9,theora,mpeg1video,mpeg2video,mpeg4,h263,flv,mjpeg"
FF_CONFIGURE+=" --enable-decoder=msmpeg4v1,msmpeg4v2,msmpeg4v3,wmv1,wmv2,cinepak,msvideo1,msrle,indeo3,indeo4,indeo5"
FF_CONFIGURE+=" --enable-decoder=bink,binkaudio_dct,binkaudio_rdft,smacker,smackaud,roq,roq_dpcm"
FF_CONFIGURE+=" --enable-decoder=pcm_s16le,pcm_u8,pcm_s24le,pcm_f32le,adpcm_ms,adpcm_ima_wav,truespeech,gsm_ms"
FF_CONFIGURE+=" --enable-decoder=mp2,mp3,aac,vorbis,opus,flac"
FF_CONFIGURE+=" --enable-parser=h264,vp8,vp9,mpegvideo,mpeg4video,mpegaudio,aac,vorbis,opus,flac"
