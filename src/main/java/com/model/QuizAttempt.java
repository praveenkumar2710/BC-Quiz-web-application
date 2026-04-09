package com.model;

public class QuizAttempt {

    private int attemptId;
    private String subjectName;
    private String topicName;
    private int score;
    private int total;
    private String attemptTime;

    public int getAttemptId() { return attemptId; }
    public void setAttemptId(int attemptId) { this.attemptId = attemptId; }

    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

    public String getTopicName() { return topicName; }
    public void setTopicName(String topicName) { this.topicName = topicName; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public String getAttemptTime() { return attemptTime; }
    public void setAttemptTime(String attemptTime) { this.attemptTime = attemptTime; }
}
