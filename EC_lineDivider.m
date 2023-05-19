function  EC_lineDivider()
clc;
close all;
%======================================
%change parameters here 
    np=6;
    parentNum=3;
    epoch=20;
    data=load('input.txt');
    
%======================================
    k=max(abs(data))
    axisSize=max(k(1),k(2))+1;
    n=size(data,1); 
    showdata(data,axisSize);
    pop=initialPopulation(np);    
    find=0;
    for iter=1:epoch        
        for i=1:np
            f(i)=fitness(pop(i), data);
        end
        bestfit(iter)=max(f);
        meanfit(iter)=mean(f);
        %------------------------------------------------------------------
        sol=findSolution(f,size(data,1));
        if (sol>0)
            showLine(pop(sol),axisSize);
            find=1;
            
            break;
        end
        %------------------------------------------------------------------
        parents=parentSelection(pop,f,parentNum);
        childeren=siblingCreator(parents);
        pop=survivorSelector(childeren,pop,data);
    end
    if (find==0)
        iter
        for i=1:np
            f(i)=fitness(pop(i), data);
        end
        [x,y]=max(f);
        showLine(pop(y),axisSize);        
    end
    figure(2);
    subplot(2,1,1);
    plot(bestfit,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
    title('best fitness');
    
    subplot(2,1,2);
    plot(meanfit,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
    title('mean fitness');
end
%==========================================================================
function [line]=initialPopulation(np)
    line=randi(np,1,[0,180]);
    
end
%==========================================================================
function [newLine]= mutation(line)
    newLine=line + randi(1,1,[1,10]);
end
%==========================================================================
function [newpop]=survivorSelector(childeren,current,points)
    
    np=size(current,1);
    %the k best will be selectet. remaining select base on their fitness
    k=np;
    %newpop=[];
    for i=1:np
            f(i)=fitness(current(i), points);
    end
   
    for i=np+1:np+size(childeren,2)
            f(i)=fitness(childeren(i-np), points);
    end
    i=1;
    currentNum=np;
    
    while (i<=k)
        [x,y]=max(f);
        %f(y)=[];
        f(y)=-1;
        if(y<=currentNum)
            new=current(y);   
            %current(y)=[];
            %currentNum=currentNum-1;
        else
            new=childeren(y-currentNum);
            %childeren(y-currentNum)=[];
        end
        %if (size(find(newpop==new),2)==0)  %agar tekrari nist
            newpop(i)=new;
            i=i+1;
        %end
    end
    newpop=newpop';
   
    %----------------------------------------------------------------------
%     while(i<=np && size(f,2)>0)
%         sigma=sum(f);
%         pointer=randint(1,1,[0,sigma]); 
%         j=1;
%         s=f(1);
%         while (s<pointer)
%             j=j+1;
%             s=s+f(j);
%         end
%         f(j)=[];
%         if(j<=currentNum)
%             new=current(j);   
%             current(j)=[];
%             currentNum=currentNum-1;
%         else
%             new=childeren(j-currentNum);
%             childeren(j-currentNum)=[];
%         end
%         
%         if (size(find(newpop==new),2)==0)  %agar tekrari nist
%             newpop(i)=new;
%             i=i+1;
%         end
%     end
    
    %----------------------------------------------------------------------
    
   
end
%==========================================================================
function [childeren]=siblingCreator(parents)
k=1;
for i=1:size(parents,2)
    for j=1:i-1
        childeren(k)=(parents(i)+parents(j))/2;
        % the probability of mutation is  20% for each of sibling
        if (randint(1,1,5)==0)
            childeren(k)=mutation(childeren(k));
        end
        k=k+1;
    end
end

end
%==========================================================================
function [parents]=parentSelection(current,fitness,num)
sigma=sum(fitness);
for i=1:num
    pointer=randint(1,1,[0,sigma]); 
    j=1;
    s=fitness(1);
    while (s<pointer)
        j=j+1;
        s=s+fitness(j);
    end
    parents(i)=current(j);    
end
end
%==========================================================================
function [index]=findSolution(fitness,dataNum)
    np=size(fitness,1);
    index=0;
    for i=1:np
        if (fitness(i)==dataNum)
            index=i;
            return;
        end
    end
end

%==========================================================================
function [f]=fitness(line, points)
right=[0,0];
left=[0,0];
for i=1:size(points,1) 
    deg=atand(points(i,2)/points(i,1));
    if (points(i,2)<0&&deg>0)
        deg=deg+180;
    end
    if (deg<0 && points(i,2)<0)
        deg=360+deg;
    end
    if (deg<0 && points(i,2)>0)
        deg=180+deg;
    end
    
    
    if (deg> line && deg<line +180)
        left(points(i,3))=left(points(i,3))+1;
        
    end 
    if(deg<line || deg > line + 180) 
        right(points(i,3))=right(points(i,3))+1;
    end
        
    
    
end

if (left(2)+right(1)>left(1)+right(2))
    f=left(2)+right(1);
else
    f=left(1)+right(2);
end

end
%==========================================================================
function showLine(line,axisSize)
figure(1);
hold on;
%xlim=[-1*axisSize axisSize];
%ylim=[-1*axisSize axisSize];
axis([-1*axisSize axisSize -1*axisSize axisSize]);
x=axisSize;
y=axisSize*tand(line);
plot([0,0],[-1*axisSize,axisSize],'-y');
plot([-1*axisSize,axisSize],[0,0],'-y');
plot([-1*axisSize,x],[-1*y,y],'-');
end
%==========================================================================
function showdata(points,axisSize)
figure(1);
hold on;

axis([-1*axisSize axisSize -1*axisSize axisSize]);
plot([0,0],[-1*axisSize,axisSize],'-y');
plot([-1*axisSize,axisSize],[0,0],'-y');
    for i=1:size(points,1)
        if (points(i,3)==2)
            plot(points(i,1),points(i,2),'g*');
            points(i,1);
            points(i,2);
        else
            plot(points(i,1),points(i,2),'ro');
        end
    end  
end
%==========================================================================