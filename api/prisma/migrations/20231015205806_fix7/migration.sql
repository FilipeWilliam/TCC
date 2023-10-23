/*
  Warnings:

  - You are about to drop the column `points` on the `Users` table. All the data in the column will be lost.
  - Changed the type of `status` on the `UserTasks` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "UserTasks" DROP COLUMN "status",
ADD COLUMN     "status" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "points";

-- DropEnum
DROP TYPE "UserTaskStatus";
