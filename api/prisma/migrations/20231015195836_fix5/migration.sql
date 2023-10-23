/*
  Warnings:

  - You are about to drop the `UserTaskQuestion` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_questionId_fkey";

-- DropTable
DROP TABLE "UserTaskQuestion";

-- CreateTable
CREATE TABLE "UserTaskQuestions" (
    "id" SERIAL NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "questionId" INTEGER NOT NULL,
    "alternative" INTEGER NOT NULL,
    "userTaksId" INTEGER NOT NULL,

    CONSTRAINT "UserTaskQuestions_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "UserTaskQuestions" ADD CONSTRAINT "UserTaskQuestions_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Questions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTaskQuestions" ADD CONSTRAINT "UserTaskQuestions_userTaksId_fkey" FOREIGN KEY ("userTaksId") REFERENCES "UserTasks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
