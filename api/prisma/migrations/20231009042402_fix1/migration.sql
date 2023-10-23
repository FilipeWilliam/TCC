/*
  Warnings:

  - You are about to drop the `Badges` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Institution` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Question` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `QuestionAlternative` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Task` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserBadges` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserTask` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Question" DROP CONSTRAINT "Question_taskId_fkey";

-- DropForeignKey
ALTER TABLE "QuestionAlternative" DROP CONSTRAINT "QuestionAlternative_questionId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_institutionId_fkey";

-- DropForeignKey
ALTER TABLE "UserBadges" DROP CONSTRAINT "UserBadges_badgeId_fkey";

-- DropForeignKey
ALTER TABLE "UserBadges" DROP CONSTRAINT "UserBadges_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserSubjects" DROP CONSTRAINT "UserSubjects_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserTask" DROP CONSTRAINT "UserTask_taskId_fkey";

-- DropForeignKey
ALTER TABLE "UserTask" DROP CONSTRAINT "UserTask_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_alternativeId_fkey";

-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_questionId_fkey";

-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_userTaskId_fkey";

-- DropTable
DROP TABLE "Badges";

-- DropTable
DROP TABLE "Institution";

-- DropTable
DROP TABLE "Question";

-- DropTable
DROP TABLE "QuestionAlternative";

-- DropTable
DROP TABLE "Task";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "UserBadges";

-- DropTable
DROP TABLE "UserTask";

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "type" INTEGER NOT NULL,
    "institutionId" INTEGER,
    "points" INTEGER,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Institutions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,

    CONSTRAINT "Institutions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tasks" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserTasks" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "taskId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "status" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,

    CONSTRAINT "UserTasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Questions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "taskId" INTEGER NOT NULL,

    CONSTRAINT "Questions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuestionAlternatives" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "isCorrect" BOOLEAN NOT NULL,
    "questionId" INTEGER NOT NULL,

    CONSTRAINT "QuestionAlternatives_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institutions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSubjects" ADD CONSTRAINT "UserSubjects_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTasks" ADD CONSTRAINT "UserTasks_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Tasks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTasks" ADD CONSTRAINT "UserTasks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Questions" ADD CONSTRAINT "Questions_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Tasks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionAlternatives" ADD CONSTRAINT "QuestionAlternatives_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Questions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTaskQuestion" ADD CONSTRAINT "UserTaskQuestion_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Questions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTaskQuestion" ADD CONSTRAINT "UserTaskQuestion_alternativeId_fkey" FOREIGN KEY ("alternativeId") REFERENCES "QuestionAlternatives"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTaskQuestion" ADD CONSTRAINT "UserTaskQuestion_userTaskId_fkey" FOREIGN KEY ("userTaskId") REFERENCES "UserTasks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
