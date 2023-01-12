enum WorkoutDistance {
  near, middle, far;
get desc => ['너무 가깝습니다', '', '좀 더 가까이 와주세요'][index];
}

enum WorkoutView {
  front, side, back, unrecognized;
get kr => ['정면', '측면', '후면', ''][index];
}

enum WorkoutStage { ready, down, up, fast }
enum WorkoutState { stop, ready, workout }
