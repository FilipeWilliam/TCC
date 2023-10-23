-- AlterTable
ALTER TABLE "UserTaskQuestions" ADD COLUMN     "finishedAt" TIMESTAMPTZ(3),
ADD COLUMN     "focusOut" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "startedAt" TIMESTAMPTZ(3);
