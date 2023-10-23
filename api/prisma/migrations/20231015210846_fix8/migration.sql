/*
  Warnings:

  - You are about to drop the column `userTaksId` on the `UserTaskQuestions` table. All the data in the column will be lost.
  - Added the required column `userTaskId` to the `UserTaskQuestions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "UserTaskQuestions" DROP CONSTRAINT "UserTaskQuestions_userTaksId_fkey";

-- AlterTable
ALTER TABLE "UserTaskQuestions" DROP COLUMN "userTaksId",
ADD COLUMN     "userTaskId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "UserTaskQuestions" ADD CONSTRAINT "UserTaskQuestions_userTaskId_fkey" FOREIGN KEY ("userTaskId") REFERENCES "UserTasks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
