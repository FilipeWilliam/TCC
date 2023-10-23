/*
  Warnings:

  - You are about to drop the column `alternativeId` on the `UserTaskQuestion` table. All the data in the column will be lost.
  - You are about to drop the column `userTaskId` on the `UserTaskQuestion` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `UserTasks` table. All the data in the column will be lost.
  - You are about to drop the `QuestionAlternatives` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `alternative1` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alternative2` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alternative3` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alternative4` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `correctAlternative` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `level` to the `Questions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alternative` to the `UserTaskQuestion` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "QuestionAlternatives" DROP CONSTRAINT "QuestionAlternatives_questionId_fkey";

-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_alternativeId_fkey";

-- DropForeignKey
ALTER TABLE "UserTaskQuestion" DROP CONSTRAINT "UserTaskQuestion_userTaskId_fkey";

-- AlterTable
ALTER TABLE "Questions" ADD COLUMN     "alternative1" TEXT NOT NULL,
ADD COLUMN     "alternative2" TEXT NOT NULL,
ADD COLUMN     "alternative3" TEXT NOT NULL,
ADD COLUMN     "alternative4" TEXT NOT NULL,
ADD COLUMN     "correctAlternative" INTEGER NOT NULL,
ADD COLUMN     "level" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "UserTaskQuestion" DROP COLUMN "alternativeId",
DROP COLUMN "userTaskId",
ADD COLUMN     "alternative" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "UserTasks" DROP COLUMN "status";

-- DropTable
DROP TABLE "QuestionAlternatives";
