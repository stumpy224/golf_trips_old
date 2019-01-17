module TeamsHelper
  def get_points_plus_minus_color(points_plus_minus)
    points_plus_minus.nil? ? '' : (points_plus_minus > 0 ? 'green' : (points_plus_minus < 0 ? 'red' : ''))
  end

  def get_strokes_class(points)
    if points == 1
      return "bogey"
    elsif points == 3
      return "birdie"
    elsif points == 4
      return "eagle"
    elsif points == 0
      return "double-bogey"
    end
  end

  def get_teams_by_golfer(outing_golfer_id)
    Team.where(outing_golfer_id: outing_golfer_id).includes(:scores).references(:scores).order(:team_date)
  end

  def get_golfers_by_team_and_date(team_number, team_date)
    Team.where(team_number: team_number, team_date: team_date).includes(scores: :hole).references(scores: :hole).order(:rank_letter)
  end

  def get_teams_by_date_ordered_by_points(outing_id, team_date)
    sql = "select teams.*,
       golfers.first_name,
       golfers.last_name,
       (select scores.points
        from scores
               join holes hdcp_1 on scores.hole_id = hdcp_1.id and hdcp_1.handicap = 1
        where scores.team_id = teams.id) AS HDCP_1_PTS,
       (select scores.points
        from scores
               join holes hdcp_2 on scores.hole_id = hdcp_2.id and hdcp_2.handicap = 2
        where scores.team_id = teams.id) AS HDCP_2_PTS,
       (select scores.points
        from scores
               join holes hdcp_3 on scores.hole_id = hdcp_3.id and hdcp_3.handicap = 3
        where scores.team_id = teams.id) AS HDCP_3_PTS,
       (select scores.points
        from scores
               join holes hdcp_4 on scores.hole_id = hdcp_4.id and hdcp_4.handicap = 4
        where scores.team_id = teams.id) AS HDCP_4_PTS,
       (select scores.points
        from scores
               join holes hdcp_5 on scores.hole_id = hdcp_5.id and hdcp_5.handicap = 5
        where scores.team_id = teams.id) AS HDCP_5_PTS,
       (select scores.points
        from scores
               join holes hdcp_6 on scores.hole_id = hdcp_6.id and hdcp_6.handicap = 6
        where scores.team_id = teams.id) AS HDCP_6_PTS,
       (select scores.points
        from scores
               join holes hdcp_7 on scores.hole_id = hdcp_7.id and hdcp_7.handicap = 7
        where scores.team_id = teams.id) AS HDCP_7_PTS,
       (select scores.points
        from scores
               join holes hdcp_8 on scores.hole_id = hdcp_8.id and hdcp_8.handicap = 8
        where scores.team_id = teams.id) AS HDCP_8_PTS,
       (select scores.points
        from scores
               join holes hdcp_9 on scores.hole_id = hdcp_9.id and hdcp_9.handicap = 9
        where scores.team_id = teams.id) AS HDCP_9_PTS,
       (select scores.points
        from scores
               join holes hdcp_10 on scores.hole_id = hdcp_10.id and hdcp_10.handicap = 10
        where scores.team_id = teams.id) AS HDCP_10_PTS,
       (select scores.points
        from scores
               join holes hdcp_11 on scores.hole_id = hdcp_11.id and hdcp_11.handicap = 11
        where scores.team_id = teams.id) AS HDCP_11_PTS,
       (select scores.points
        from scores
               join holes hdcp_12 on scores.hole_id = hdcp_12.id and hdcp_12.handicap = 12
        where scores.team_id = teams.id) AS HDCP_12_PTS,
       (select scores.points
        from scores
               join holes hdcp_13 on scores.hole_id = hdcp_13.id and hdcp_13.handicap = 13
        where scores.team_id = teams.id) AS HDCP_13_PTS,
       (select scores.points
        from scores
               join holes hdcp_14 on scores.hole_id = hdcp_14.id and hdcp_14.handicap = 14
        where scores.team_id = teams.id) AS HDCP_14_PTS,
       (select scores.points
        from scores
               join holes hdcp_15 on scores.hole_id = hdcp_15.id and hdcp_15.handicap = 15
        where scores.team_id = teams.id) AS HDCP_15_PTS,
       (select scores.points
        from scores
               join holes hdcp_16 on scores.hole_id = hdcp_16.id and hdcp_16.handicap = 16
        where scores.team_id = teams.id) AS HDCP_16_PTS,
       (select scores.points
        from scores
               join holes hdcp_17 on scores.hole_id = hdcp_17.id and hdcp_17.handicap = 17
        where scores.team_id = teams.id) AS HDCP_17_PTS,
       (select scores.points
        from scores
               join holes hdcp_18 on scores.hole_id = hdcp_18.id and hdcp_18.handicap = 18
        where scores.team_id = teams.id) AS HDCP_18_PTS
from teams
       join outing_golfers on teams.outing_golfer_id = outing_golfers.id
       join golfers on outing_golfers.golfer_id = golfers.id
       join outings on outing_golfers.outing_id = outings.id
where outings.id = :outing_id
  and teams.team_date = :team_date
order by teams.points_actual desc, HDCP_1_PTS desc, HDCP_2_PTS desc, HDCP_3_PTS desc, HDCP_4_PTS desc, HDCP_5_PTS desc,
         HDCP_6_PTS desc, HDCP_7_PTS desc, HDCP_8_PTS desc, HDCP_9_PTS desc, HDCP_10_PTS desc, HDCP_11_PTS desc,
         HDCP_12_PTS desc, HDCP_13_PTS desc, HDCP_14_PTS desc, HDCP_15_PTS desc, HDCP_16_PTS desc,
         HDCP_17_PTS desc, HDCP_18_PTS desc"

    Team.find_by_sql([sql, {outing_id: outing_id, team_date: team_date}])
  end

  def get_teams_ranking_by_date(outing_id, team_date)
    sql = "select teams.team_number,
       sum(teams.points_expected)                                                       AS team_points_expected,
       sum(teams.points_actual)                                                         AS team_points_actual,
       sum(teams.points_actual) - sum(teams.points_expected)                            AS team_points_plus_minus,
       (select sum(scores.points)
        from scores
               join holes hdcp_1 on scores.hole_id = hdcp_1.id and hdcp_1.handicap = 1
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_1_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_2 on scores.hole_id = hdcp_2.id and hdcp_2.handicap = 2
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_2_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_3 on scores.hole_id = hdcp_3.id and hdcp_3.handicap = 3
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_3_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_4 on scores.hole_id = hdcp_4.id and hdcp_4.handicap = 4
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_4_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_5 on scores.hole_id = hdcp_5.id and hdcp_5.handicap = 5
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_5_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_6 on scores.hole_id = hdcp_6.id and hdcp_6.handicap = 6
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_6_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_7 on scores.hole_id = hdcp_7.id and hdcp_7.handicap = 7
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_7_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_8 on scores.hole_id = hdcp_8.id and hdcp_8.handicap = 8
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_8_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_9 on scores.hole_id = hdcp_9.id and hdcp_9.handicap = 9
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_9_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_10 on scores.hole_id = hdcp_10.id and hdcp_10.handicap = 10
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_10_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_11 on scores.hole_id = hdcp_11.id and hdcp_11.handicap = 11
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_11_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_12 on scores.hole_id = hdcp_12.id and hdcp_12.handicap = 12
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_12_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_13 on scores.hole_id = hdcp_13.id and hdcp_13.handicap = 13
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_13_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_14 on scores.hole_id = hdcp_14.id and hdcp_14.handicap = 14
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_14_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_15 on scores.hole_id = hdcp_15.id and hdcp_15.handicap = 15
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_15_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_16 on scores.hole_id = hdcp_16.id and hdcp_16.handicap = 16
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_16_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_17 on scores.hole_id = hdcp_17.id and hdcp_17.handicap = 17
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_17_PTS,
       (select sum(scores.points)
        from scores
               join holes hdcp_18 on scores.hole_id = hdcp_18.id and hdcp_18.handicap = 18
        where scores.team_id in (select id from teams t2 where t2.team_number = teams.team_number)) AS HDCP_18_PTS
from teams
       join outing_golfers on teams.outing_golfer_id = outing_golfers.id
       join outings on outing_golfers.outing_id = outings.id
where outings.id = :outing_id
  and teams.team_date = :team_date
  and teams.team_number is not null
group by teams.team_number
order by team_points_plus_minus desc, teams.team_number, HDCP_1_PTS desc, HDCP_2_PTS desc, HDCP_3_PTS desc,
         HDCP_4_PTS desc, HDCP_5_PTS desc,
         HDCP_6_PTS desc, HDCP_7_PTS desc, HDCP_8_PTS desc,
         HDCP_9_PTS desc, HDCP_10_PTS desc, HDCP_11_PTS desc, HDCP_12_PTS desc, HDCP_13_PTS desc, HDCP_14_PTS desc,
         HDCP_15_PTS desc, HDCP_16_PTS desc,
         HDCP_17_PTS desc, HDCP_18_PTS desc"

    Team.find_by_sql([sql, {outing_id: outing_id, team_date: team_date}])
  end

  def get_overall_stats_by_outing(outing_id)
    sql = "select teams.outing_golfer_id,
       golfers.first_name || ' ' || golfers.last_name                                 AS golfer_name,
       sum(teams.points_expected)                                                     AS total_points_expected,
       sum(teams.points_actual)                                                       AS total_points_actual,
       sum(teams.points_plus_minus)                                                   AS total_points_plus_minus,
       avg(teams.points_actual)                                                       AS avg_points_actual,
       (select sum(scores.strokes)
        from scores
        where scores.team_id in (select id
                                 from teams t2
                                 where t2.outing_golfer_id = teams.outing_golfer_id)) AS total_strokes,
       count(teams.team_date)                                                         AS outing_days_counted
from teams
       join outing_golfers on teams.outing_golfer_id = outing_golfers.id
       join outings on outing_golfers.outing_id = outings.id
       join golfers on outing_golfers.golfer_id = golfers.id
where outings.id = :outing_id
  and teams.points_actual is not null
group by teams.outing_golfer_id, golfer_name
order by total_points_actual desc, avg_points_actual desc, total_strokes"

    Team.find_by_sql([sql, {outing_id: outing_id}])
  end
end
