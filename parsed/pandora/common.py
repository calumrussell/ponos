import math

class Shot:

    body_parts = [20,72,15,21]
    pattern_of_plays = [22,23,24,25,26,9,160,241]
    shot_locations = [60,61,62,63,64,65,66,67,68,69,70,71,16,17,18,19]

    x_scale = 0.9457
    y_scale = 0.76

    def __repr__(self):
        return f"distance: {self.distance}, angle: {self.angle}, shot_location: {self.shot_location}, shot_play: {self.shot_play}, body_part: {self.body_part}"

    def _calc_distance(self):
        middle = [100 * Shot.x_scale, 50 * Shot.y_scale]
        temp = [middle[0] - self.x, middle[1] - self.y]
        return math.sqrt((temp[0] * temp[0]) + (temp[1] * temp[1]))

    def _calc_angle(self):
        post1 = [100 * Shot.x_scale, 54.8 * Shot.y_scale]
        post2 = [100 * Shot.x_scale, 45.2 * Shot.y_scale]

        post1_minus_shot = [post1[0] - self.x, post1[1] - self.y]
        post2_minus_shot = [post2[0] - self.x, post2[1] - self.y]

        dot_prod = (post1_minus_shot[0] * post2_minus_shot[0]) + (post1_minus_shot[1] * post2_minus_shot[1])
        post1_norm = math.sqrt((post1_minus_shot[0] * post1_minus_shot[0]) + (post1_minus_shot[1] * post1_minus_shot[1]))
        post2_norm = math.sqrt((post2_minus_shot[0] * post2_minus_shot[0]) + (post2_minus_shot[1] * post2_minus_shot[1]))
        return math.acos(dot_prod / (post1_norm * post2_norm)) * (180/math.pi)

    def _calc_shot_location(self):
        for qualifier in self.qualifiers:
            qual_type = qualifier.get("type")
            if qual_type.get('value') in Shot.shot_locations:
                return qual_type['displayName']
        return None

    def _calc_body_part(self):
        for qualifier in self.qualifiers:
            qual_type = qualifier.get("type")
            if qual_type.get('value') in Shot.body_parts:
                return qual_type['displayName']
        return None

    def _calc_shot_play(self):
        for qualifier in self.qualifiers:
            qual_type = qualifier.get("type")
            if qual_type.get('value') in Shot.pattern_of_plays:
                return qual_type['displayName']
        return None

    def _calc_shot_result(self):
        if self.event.get('isGoal'):
            return 1
        return 0

    def __init__(self, event):
        self.event = event
        self.x = event['x']
        self.y = event['y']
        self.player_id = event.get('playerId')
        self.event_id = event.get('eventId')
        self.qualifiers = event.get('qualifiers', [])
        self.distance = self._calc_distance()
        self.angle = self._calc_angle()
        self.shot_location = self._calc_shot_location()
        self.body_part = self._calc_body_part()
        self.shot_play = self._calc_shot_play()
        self.result = self._calc_shot_result()

