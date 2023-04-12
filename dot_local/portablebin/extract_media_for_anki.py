import sys
import json
import subprocess
import os
from datetime import datetime, timedelta
from uuid import uuid4


def extract_audio(video_file, start_time, end_time, output_file):
    start_time = datetime.strptime(start_time, "%H:%M:%S.%f") - timedelta(seconds=2)
    end_time = datetime.strptime(end_time, "%H:%M:%S.%f") + timedelta(seconds=5)
    start_time_str = start_time.strftime("%H:%M:%S.%f")[:-3]
    end_time_str = end_time.strftime("%H:%M:%S.%f")[:-3]
    command = f"ffmpeg -i {video_file} -ss {start_time_str} -to {end_time_str} -vn -acodec libmp3lame {output_file}"
    subprocess.run(command, shell=True, check=True)


def extract_image(video_file, time, output_file):
    output_file.replace("[", r"\[").replace("]", r"\]")
    command = f'ffmpeg -i "{video_file}" -ss {time} -vframes 1 "{output_file}"'
    subprocess.run(command, shell=True, check=True)


def process_json_list(json_list, video_file):
    for item in json_list:
        start_time = fix_time_format(item["start_time"])
        end_time = fix_time_format(item["end_time"])
        uuid_str = str(uuid4())
        audio_file = f"{video_file}_{uuid_str}.mp3"
        img_file = f"{video_file}_{uuid_str}.jpg"

        extract_audio(video_file, start_time, end_time, audio_file)
        extract_image(video_file, start_time, img_file)

        item["audio_file"] = os.path.abspath(audio_file)
        item["img_file"] = os.path.abspath(img_file)
        del item["start_time"]
        del item["end_time"]

    return json_list


def fix_time_format(time_str):
    if "," in time_str:
        time_str = time_str.replace(",", ".")
    return time_str


def main():
    video_file = sys.argv[1]
    json_list = json.loads(sys.stdin.read())
    new_json_list = process_json_list(json_list, video_file)
    print(json.dumps(new_json_list, indent=2))


if __name__ == "__main__":
    main()
