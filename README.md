# captioning-synchronization

Abstract — Theatre has certain features that make real-time subtitling of a performance a much more complex task when compared to audio-visual content like music or cinema. This work describes a system to synchronize the subtitling of a theatrical performance using the audio signal coming from the show and a content database built from previous performances. The underlying idea is to estimate the playback timing in which the current performance is found. For this purpose, techniques such as Automatic Content Recognition (ACR) and image processing over the spectrogram of the audio signal are applied. In a complementary way, the proposed system has been evaluated using audio recordings of a wide variety of sources. So, the influence of the audio quality over the performance of the system have also been studied. The main goal of this work is to lay the groundwork that allows the operation of the system under real-time conditions.

## I. Introduction

In recent years, the irruption of mobile devices has changed the way in which people consume digital content. The second screen is a concept referring to the use of mobile devices as a complementary way of information and services that does not directly interrupt the reproduction of the main content [1], [2]. Although the application of the second screen is evident in cinema or television, it can also be applied in environments such as theatre to distribute, for example, the subtitling of a play. However, live theatre cannot be considered as a common digital content like cinema or music. While the audio track of a movie is stored into a digital media and therefore, the same information is always played with each new playback, the audio track coming from each performance for a given play presents slight differences over time.

The audio signal coming from contents such as music or cinema is always the same between different playbacks. Here, the audio can suffer alterations mainly related to variation in the playback speed or pitch. However, theatre is a more complex scenario: there are other factors like modifications over the script, substitutions of actors or variations in the cadence when speaking that make the audio signal differs from one performance to another. The playback of subtitles in theatre through a second screen needs a synchronization algorithm adaptable to the particular alterations suffered by the audio signal in this environment.

Nowadays, platforms such as [ACR Cloud](www.acrcloud.com), [Axwave](www.axwave.com) or [Mufin](www.mufin.com) offer both recognition and synchronization of audio-visual contents through a second screen. Likewise, applications like [Shazam](www.shazam.com) or [Sound Hound](www.soundhound.com) perform both song identification and lyrics synchronization. All these applications are based on extraction and indexing of acoustic fingerprints from audio sources by means of proprietary algorithms.

However, subtitling synchronization processes in theatre are not yet automated. Software tools like [QLab](figure53.com/qlab), [STARTIT](www.startit-app.com) or even [Power Point](products.office.com/esus/powerpoint) allow to create the captions for a play. However, synchronized playback of captions during the performance have to be done manually by means of a technician. The need for human intervention translates into high costs and hence, the need of finding a way of automating this process arises.

The research presented in this work is part of the ["Teatro Accesible" project](www.teatroaccesible.com). The aims of this project are to provide sensory accessibility to the scenic spaces through the use of new technologies. As a result, more than 360 plays have been adapted in more than 85 theatres in Spain since 2011.

The main goal of this work is the definition of a realtime procedure to synchronize the playback of subtitles in a theatre play. The key idea is to use an audio recording of a given theatre play in order to build a database which enables the estimation of the timing of a new show using the characterization done from the reference audio.

The rest of this paper is organized as follows. Section 2 presents a study of the state of the art concerning audio synchronization. Next, section 3 contains a detailed description of the proposed system. Section 4 refers to the experimental methodology adopted to evaluate the system and shows the results. Finally, in section 5, the main conclusions are discussed and the lines of future work are detailed.
